//
//  SettingView.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var service: Auth0Service
    @ObservedObject var viewModel = SettingViewModel()
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: screenWidth * 0.9, height: 100)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 6)
                
                VStack {
                    Text("\(viewModel.name)")
                        .font(.largeTitle)
                        .bold()
                        .shadow(radius: 5)
                        .padding(.vertical, 5)
                    Text("User ID：\(viewModel.userID)")
                        .font(.headline)
                        .shadow(radius: 5)
                        .padding(.bottom, 5)
                }
            }
            .padding()
            
            // 設定部分
            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.gray)
                            .padding(.leading, 25)
                        Text("Checking and changing settings")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .bold()
                        Spacer()
                    }
                    let settingLabels: [Text] = [Text("Name"), Text("User ID"), Text("Wake-up time"), Text("Day of week")]
                    ForEach(0 ..< settingLabels.count, id: \.self) { index in
                        SettingNavigationCard(textContent: {
                            settingLabels[index]
                        }, action: {
                            router.navigateToView(destination: router.settingNavigationPath[index])
                        })
                    }
                }
                .padding(.bottom)
                
                // フレンド
                VStack {
                    HStack {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.gray)
                            .padding(.leading, 25)
                        Text("Friend")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .bold()
                        Spacer()
                    }
                    let friendLabels: [Text] = [Text("Find Friends")]
                    ForEach(0 ..< friendLabels.count, id: \.self) { index in
                        SettingNavigationCard(textContent: {
                            friendLabels[index]
                        }, action: {
                            router.navigateToView(destination: router.friendNavigationPath[index])
                        })
                    }
                    SettingNavigationCardIncludeExclamationMark(textContent: {
                        Text("Friend Approval")
                    }, isShowMark: true, action: {
                        router.navigateToView(destination: .friendApproval)
                    })
                }
                .padding(.bottom)
                
                // その他
                VStack {
                    HStack {
                        Text("Other")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .bold()
                            .padding(.leading, 25)
                        Spacer()
                    }
                    let othersLabels: [Text] = [Text("Penalty History")]
                    ForEach(0 ..< othersLabels.count, id: \.self) { index in
                        SettingNavigationCard(textContent: {
                            othersLabels[index]
                        }, action: {
                            router.navigateToView(destination: router.friendNavigationPath[index])
                        })
                    }
                }
                .padding(.bottom)
                
                LogoutButton(action: {
                    service.logout()
                })
            }
        }
        .onChange(of: service.isAuthenticated) {
            if !service.isAuthenticated {
                router.resetPath()
            }
        }
    }
    
    @ViewBuilder
    func SettingNavigationCard(textContent: @escaping () -> Text, action: @escaping () -> Void) -> some View {
        let screenWidth = UIScreen.main.bounds.width
        
        Button(action: action) {
            ZStack {
                let cornerRadius = 10.0
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(.black, lineWidth: 1)
                    )
                HStack {
                    textContent()
                        .foregroundColor(.black)
                        .font(.title2)
                        .bold()
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
            .frame(width: screenWidth * 0.9, height: 50)
        }
    }
    
    @ViewBuilder
    func SettingNavigationCardIncludeExclamationMark(textContent: @escaping () -> Text, isShowMark: Bool, action: @escaping () -> Void) -> some View {
        let screenWidth = UIScreen.main.bounds.width
        
        Button(action: action) {
            ZStack {
                let cornerRadius = 10.0
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(.black, lineWidth: 1)
                    )
                HStack {
                    textContent()
                        .foregroundColor(.black)
                        .font(.title2)
                        .bold()
                    Spacer()
                    Image(systemName: "exclamationmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                        .opacity(isShowMark ? 1.0 : 0.0)
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
            .frame(width: screenWidth * 0.9, height: 50)
        }
    }
}

// 以降、各種設定画面への遷移後のビュー
struct SettingNameView: View {
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject var viewModel: SettingViewModel
    
    var body: some View {
        AccountSettingName(viewModel: AccountCommonNameViewModel(), nextButtonLabel: Text("Change!"), isShowBackButton: true, routerAction: {
            router.backPage()
            viewModel.putUserData()
        })
        .navigationBarHidden(true)
    }
}

struct SettingUserIDView: View {
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject var viewModel: SettingViewModel
    
    var body: some View {
        AccountSettingUserID(viewModel: AccountCommonUserIDViewModel(), nextButtonLabel: Text("Change!"), action: {
            router.backPage()
            viewModel.putUserData()
        })
        .navigationBarHidden(true)
    }
}

struct SettingWakeUpTimeView: View {
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject var viewModel: TimeSettingViewModel
    
    var body: some View {
        AccountSettingWakeUpTime(nextButtonLabel: Text("Change!"), action: {
            router.backPage()
            viewModel.putUserData()
        })
        .navigationBarHidden(true)
    }
}

struct SettingDayOfWeekView: View {
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject var viewModel: TimeSettingViewModel
    
    var body: some View {
        AccountSettingDayOfWeek(viewModel:AccountCommonDayOfWeekViewModel(),nextButtonLabel: Text("Change!"), action: {
            router.backPage()
            viewModel.putUserData()
        })
        .navigationBarHidden(true)
    }
}
