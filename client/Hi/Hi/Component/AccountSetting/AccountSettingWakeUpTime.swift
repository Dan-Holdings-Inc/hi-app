//
//  AccountSettingWakeUpTime.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import SwiftUI

struct AccountSettingWakeUpTime: View {
    @State var date = Date()
    
    var nextButtonLabel: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            BackButton()
                .padding(.bottom, 5)
            HStack {
                Text("毎朝の起きる時間を設定")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("設定した時間までにフレンドにHiを送る必要があります。")
                    .padding(.horizontal)
                Spacer()
            }
            HStack {
                DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.primary, lineWidth: 1)
            )
            .padding()
            Text("\(DateFormat().dateToString(date: date))")
                .font(.title)
                .bold()
            BasicRoundButton(text: "\(nextButtonLabel)", action: {
                let stringDate = DateFormat().dateToString(date: date)
                UserDefaultsHelper().set(value: stringDate, key: "wakeUpTime")
                action()
            })
            Spacer()
        }
        .onAppear {
            let stringDate = UserDefaultsHelper().getStringData(key: "wakeUpTime")
            date = DateFormat().StringToDate(string: stringDate)
            print(date)
        }
    }
}

#Preview {
    AccountSettingWakeUpTime(nextButtonLabel: "次へ", action: {
        print("次へ行く")
    })
}
