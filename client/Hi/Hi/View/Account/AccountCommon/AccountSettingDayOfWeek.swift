//
//  AccountSettingDayOfWeek.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import SwiftUI

struct AccountSettingDayOfWeek: View {
    @Environment(\.locale) var locale
    @ObservedObject var viewModel = AccountCommonDayOfWeekViewModel()
    
    var nextButtonLabel: Text
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
            let dayOfWeekLabel: [Text] = [Text("Mon"), Text("Tue"), Text("Wed"), Text("Thu"), Text("Fri"), Text("Sat"), Text("Sun")]
            if locale.language.languageCode?.identifier ?? "" == "ja" {
                HStack {
                    ForEach(0 ..< dayOfWeekLabel.count, id: \.self) { index in
                        DayOfWeekButton(label: dayOfWeekLabel[index], isSelected: viewModel.dayOfWeekSelected[index], action: {
                            viewModel.dayOfWeekSelected[index].toggle()
                        })
                    }
                }
                .padding()
            } else {
                VStack {
                    HStack {
                        ForEach(0 ..< 3, id: \.self) { index in
                            DayOfWeekButton(label: dayOfWeekLabel[index], isSelected: viewModel.dayOfWeekSelected[index], action: {
                                viewModel.dayOfWeekSelected[index].toggle()
                            })
                        }
                    }
                    HStack {
                        ForEach(3 ..< 6, id: \.self) { index in
                            DayOfWeekButton(label: dayOfWeekLabel[index], isSelected: viewModel.dayOfWeekSelected[index], action: {
                                viewModel.dayOfWeekSelected[index].toggle()
                            })
                        }
                    }
                    HStack {
                        ForEach(6 ..< dayOfWeekLabel.count, id: \.self) { index in
                            DayOfWeekButton(label: dayOfWeekLabel[index], isSelected: viewModel.dayOfWeekSelected[index], action: {
                                viewModel.dayOfWeekSelected[index].toggle()
                            })
                        }
                    }
                }
                .padding()
            }
            
            BasicRoundButton(text: Text("\(nextButtonLabel)"), action: {
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
    AccountSettingDayOfWeek(nextButtonLabel: Text("Next"), action: {
        print("次へ")
    })
}
