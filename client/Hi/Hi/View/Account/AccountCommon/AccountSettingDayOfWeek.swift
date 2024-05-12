//
//  AccountSettingDayOfWeek.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import SwiftUI

struct AccountSettingDayOfWeek: View {
    @ObservedObject var viewModel = AccountCommonDayOfWeekViewModel()
    
    var nextButtonLabel: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            BackButton()
                .padding(.bottom, 5)
            HStack {
                Text("Select a day of the week")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("You will receive notifications for the selected days of the week.")
                    .padding(.horizontal)
                Spacer()
            }
            HStack {
                let dayOfWeekLabel = ["月", "火", "水", "木", "金", "土", "日"]
                ForEach(0 ..< dayOfWeekLabel.count, id: \.self) { index in
                    DayOfWeekButton(label: dayOfWeekLabel[index], isSelected: viewModel.dayOfWeekSelected[index], action: {
                        viewModel.dayOfWeekSelected[index].toggle()
                    })
                }
            }
            .padding()

            BasicRoundButton(text: "\(nextButtonLabel)", action: {
                viewModel.nextButtonAction()
                action()
            })
            Spacer()
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    AccountSettingDayOfWeek(nextButtonLabel: "次へ", action: {
        print("次へ")
    })
}
