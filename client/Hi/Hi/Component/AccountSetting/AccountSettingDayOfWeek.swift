//
//  AccountSettingDayOfWeek.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import SwiftUI

struct AccountSettingDayOfWeek: View {
    var nextButtonLabel: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            BackButton()
                .padding(.bottom, 5)
            HStack {
                Text("曜日を選択")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("選択した曜日は通知が届きます。")
                    .padding(.horizontal)
                Spacer()
            }
            HStack {
                DayOfWeekButton(label: "月")
                DayOfWeekButton(label: "火")
                DayOfWeekButton(label: "水")
                DayOfWeekButton(label: "木")
                DayOfWeekButton(label: "金")
                DayOfWeekButton(label: "土")
                DayOfWeekButton(label: "日")
            }
            .padding()

            BasicRoundButton(text: "\(nextButtonLabel)", action: action)
            Spacer()
        }
    }
}

#Preview {
    AccountSettingDayOfWeek(nextButtonLabel: "次へ", action: {
        print("次へ")
    })
}
