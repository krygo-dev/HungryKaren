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
    var buttonAction: () -> Void
    var onCloseAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    onCloseAction()
                }
            
            VStack(spacing: 0) {
                
                Text(alertType.message())
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                
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
                    .padding(.bottom, 16)
                
                Button {
                    buttonAction()
                } label: {
                    Text(alertType.actionButtonLabel)
                        .font(.system(size: 16, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 80, height: 30)
                        .background(alternatePrimaryColor)
                        .cornerRadius(15)
                }
            }
            .foregroundColor(secondTitleColor)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(width: 270, height: 230)
            .background(Color.white)
            .cornerRadius(25)
        }
        .zIndex(2)
    }
}
