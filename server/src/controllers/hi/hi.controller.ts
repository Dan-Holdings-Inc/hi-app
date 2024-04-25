import {
  BadRequestException,
  Controller,
  Param,
  Post,
  Req,
  UseGuards,
} from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { SNS } from "aws-sdk";
import { DbService } from "src/infrastructure/db/db.service";

@UseGuards(AuthGuard("jwt"))
@Controller("hi")
export class HiController {
  constructor(private dbService: DbService) {}
  @Post(":receiverUserId")
  async sendHi(
    @Param("receiverUserId") receiverUserId: string,
    @Req() request
  ) {
    const email = request.user.name as string;
    const sender = await this.dbService.users
      .findOne({
        email,
      })
      .lean()
      .exec();
    if (!sender) {
      //たぶんありえないが一応。
      throw new BadRequestException("sender not found");
    }
    const receiver = await this.dbService.users.findOne({
      _id: receiverUserId,
    });
    if (!receiver) {
      throw new BadRequestException("receiver not found.");
    }
    const sns = new SNS({ apiVersion: "2010-03-31" });

    const deviceToken =
      "80d747de7b6ae8063c2628576001cc49ec588582c37d827dc1b8a24f04b36cae49f3cc91ecd32f202f19742f046742058a81eb0266c17b077cf22d1ae79c081955b3e8dea4231c84d926e3ca8876bd8b";

    //Endpointの作成
    const endpoint = await sns
      .createPlatformEndpoint({
        PlatformApplicationArn:
          "arn:aws:sns:ap-northeast-1:862214078536:app/APNS_SANDBOX/hi",
        Token: deviceToken,
      })
      .promise();

    const params = {
      // MessageEvent: "json",
      TargetArn: endpoint.EndpointArn,
      Message: "通知やねん",
    };
    const res = await sns.publish(params).promise();
  }
}
