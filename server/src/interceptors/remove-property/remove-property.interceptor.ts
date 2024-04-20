import {
  CallHandler,
  ExecutionContext,
  Injectable,
  NestInterceptor,
} from "@nestjs/common";
import { Observable, map } from "rxjs";

const propertiesToRemove = ["__v"];

@Injectable()
export class RemovePropertyInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    return next.handle().pipe(
      map((value) => {
        for (const p of propertiesToRemove) {
          console.log(value[p]);
          if (value[p] !== undefined) {
            delete value[p];
          }
        }
        return value;
      })
    );
  }
}
