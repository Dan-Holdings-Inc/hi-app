//
//  AccountSettingDayOfWeek.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import SwiftUI

struct AccountSettingDayOfWeek: View {
    @State var dayOfWeekSelected = Array(repeating: false, count: 7)
    
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
                let dayOfWeekLabel = ["月", "火", "水", "木", "金", "土", "日"]
                ForEach(0 ..< dayOfWeekLabel.count, id: \.self) { index in
                    DayOfWeekButton(label: dayOfWeekLabel[index], isSelected: dayOfWeekSelected[index], action: {
                        dayOfWeekSelected[index].toggle()
                    })
                }
            }
            .padding()

            BasicRoundButton(text: "\(nextButtonLabel)", action: {
                UserDefaultsHelper().set(value: dayOfWeekSelected, key: "dayOfWeekSelected")
                action()
            })
            Spacer()
        }
        .onAppear {
            dayOfWeekSelected = UserDefaultsHelper().getArrayData(key: "dayOfWeekSelected") as? [Bool] ?? []
        }
    }
}

#Preview {
    AccountSettingDayOfWeek(nextButtonLabel: "次へ", action: {
        print("次へ")
    })
}
