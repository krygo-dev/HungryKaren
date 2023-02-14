//
//  HKAlertView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 25/01/2023.
//

import SwiftUI

struct HKAlertView: View {
    
    @State var alertType: AlertType
    @Binding var quantity: String
    @Binding var isSpice: Bool
    var buttonAction: (() -> ())
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                
                Text(alertType.title())
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .frame(height: 25)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                    .padding(.horizontal, 16)
                
                Text(alertType.message())
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .minimumScaleFactor(0.5)
                
                TextField("", text: $quantity, prompt: Text("quantity"))
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .frame(height: 30)
                    .padding(8)
                    .background(alternatePrimaryColor)
                    .cornerRadius(15)
                
                Spacer().frame(height: 20)
                
                Toggle("Product belongs to spices?", isOn: $isSpice)
                    .font(.system(size: 14))
                    .tint(alternateTertiaryColor)
                
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
            .foregroundColor(secondTitleColor)
            .padding(.horizontal, 16)
            .frame(width: 270, height: 270)
            .background(Color.white)
            .cornerRadius(10)
        }
        .zIndex(2)
    }
}
