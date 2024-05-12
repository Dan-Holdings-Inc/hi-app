//
//  AccountSettingWakeUpTime.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import SwiftUI

struct AccountSettingWakeUpTime: View {
    @State var date = Date()
    
    let dateFormatHelper = DateFormat()
    var nextButtonLabel: Text
    var action: () -> Void
    
    var body: some View {
        VStack {
            BackButton()
                .padding(.bottom, 5)
            HStack {
                Text("Set a time to get up each morning")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("You must send Hi to your friend by the set time.")
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
            Text("\(dateFormatHelper.dateToString(date: date))")
                .font(.title)
                .bold()
            BasicRoundButton(text: Text("\(nextButtonLabel)"), action: {
                let stringDate = dateFormatHelper.dateToString(date: date)
                userDefaultsHelper.set(value: stringDate, key: UserDefaultsKey.getUpAt)
                action()
            })
            Spacer()
        }
        .onAppear {
            let stringDate = userDefaultsHelper.getStringData(key: UserDefaultsKey.getUpAt)
            date = dateFormatHelper.StringToDate(string: stringDate)
        }
    }
}

#Preview {
    AccountSettingWakeUpTime(nextButtonLabel: Text("Next"), action: {
        print("次へ行く")
    })
}
