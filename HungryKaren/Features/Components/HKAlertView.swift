//
//  HKAlertView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 25/01/2023.
//

import SwiftUI

struct HKAlertView: View {
    
    @Binding var showAlert: Bool
    @State var alertType: AlertType
    var buttonAction: (() -> ())
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                Text(alertType.title())
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(height: 25)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                    .padding(.horizontal, 16)
                Text(alertType.message())
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .minimumScaleFactor(0.5)
                
                Divider()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
                    .padding(.all, 0)
                
                Button {
                    buttonAction()
                } label: {
                    Text(alertType.actionButtonLabel)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
            }
            .frame(width: 270, height: 170)
            .background(Color.white)
            .cornerRadius(10)
        }
        .zIndex(2)
    }
}
