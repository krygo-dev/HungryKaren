//
//  ProfileView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 02/02/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var navigationRouter: NavigationRouter
    @StateObject var profileViewModel = ProfileViewModel()
    
    @State var showMenu: Bool = false
    @State var showSuccesAlert: Bool = false
    @State var currentPassword: String = ""
    @State var newPassword: String = ""
    @State var newPasswordRepeat: String = ""
    
    private let fieldWidth: CGFloat = 320
    private let fieldHeight: CGFloat = 45
    
    var body: some View {
        ZStack {
            HKMainBackgroundCanvasView(color: tertiaryColor)
            
            VStack {
                HKTopBarView(title: "My profile", showMenu: $showMenu, showTopBar: .constant(true))

                ScrollView {
                    Image("person_icon_with_bg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 162, height: 162)

                    Group {
                        Text("\(profileViewModel.currentUserData?.name ?? "")")
                            .frame(width: fieldWidth, height: fieldHeight)
                            .background(quaternaryColor)
                            .cornerRadius(15)
                            .padding(.bottom, 18)

                        Text("\(profileViewModel.currentUserData?.email ?? "")")
                            .frame(width: fieldWidth, height: fieldHeight)
                            .background(quaternaryColor)
                            .cornerRadius(15)
                            .padding(.bottom, 18)
                    }
                    .foregroundColor(thirdTitleColor)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)

                    Rectangle()
                        .frame(width: 316, height: 1)
                        .foregroundColor(secondaryColor)
                    
                    Group {
                        Text("CHANGE PASSWORD")
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .padding(.vertical, 18)

                        SecureField("", text: $currentPassword, prompt: Text("current password").foregroundColor(mainTextColor))
                            .frame(width: fieldWidth, height: fieldHeight)
                            .background(quaternaryColor)
                            .cornerRadius(15)
                            .padding(.bottom, 18)
                        
                        SecureField("", text: $newPassword, prompt: Text("new password").foregroundColor(mainTextColor))
                            .frame(width: fieldWidth, height: fieldHeight)
                            .background(primaryColor)
                            .cornerRadius(15)
                            .padding(.bottom, 18)

                        SecureField("", text: $newPasswordRepeat, prompt: Text("confirm new password").foregroundColor(mainTextColor))
                            .frame(width: fieldWidth, height: fieldHeight)
                            .background(primaryColor)
                            .cornerRadius(15)
                            .padding(.bottom, 6)
                        
                        if showSuccesAlert {
                            Text("Password updated")
                                .truncationMode(.tail)
                                .foregroundColor(tertiaryColor)
                                .font(.system(size: 10))
                                .frame(width: fieldWidth, alignment: .center)
                                .padding(.bottom, 4)
                        } else {
                            Text("\(profileViewModel.alert?.message().uppercased() ?? "")")
                                .truncationMode(.tail)
                                .foregroundColor(errorTextColor)
                                .font(.system(size: 10))
                                .frame(width: fieldWidth, alignment: .center)
                                .padding(.bottom, 4)
                        }

                        Button {
                            profileViewModel.changeUserPassword(
                                email: profileViewModel.currentUserData!.email,
                                currentPassword: currentPassword,
                                newPassword: newPassword,
                                confirmNewPassword: newPasswordRepeat
                            ) {
                                if profileViewModel.alert == nil {
                                    showSuccesAlert.toggle()
                                    currentPassword = ""
                                    newPassword = ""
                                    newPasswordRepeat = ""
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        showSuccesAlert.toggle()
                                    }
                                }
                            }
                        } label: {
                            if profileViewModel.isLoading {
                                ProgressView()
                            } else {
                                Text("okay")
                                    .fontWeight(.medium)
                                    .font(.system(size: 16))
                                    .foregroundColor(mainTextColor)
                            }
                        }
                    }
                    .foregroundColor(mainTextColor)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                }
                                
                HKSecondaryBottomBarView(
                    searchText: .constant(""),
                    showBottomBar: .constant(true),
                    searchBarVisible: false,
                    searchBarButtonVisible: false
                )
            }
            
            if showMenu {
                MenuView(showMenu: $showMenu)
                    .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.5)))
            }
        }
        .navigationBarBackButtonHidden(true)
        .gesture(NavigateBackDragGesture(completion: { navigationRouter.navigateBack() }))
    }
}
