//
//  StartView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: 173)
                Image("hungry_karen_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 170)
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 65)
                    .fill(primaryColor)
                VStack {
                    Spacer().frame(height: 66)
                    Button {
                        print("sign in")
                    } label: {
                        HKButtonFrameView(text: "Sign In")
                    }
                    Spacer().frame(height: 30)
                    Button {
                        print("sign un")
                    } label: {
                        HKButtonFrameView(text: "Register")
                    }
                    Spacer()
                }
            }
            .position(x: 195, y: 466)
            .frame(width: 390, height: 466)
        }
        .ignoresSafeArea()
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
