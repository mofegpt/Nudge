//
//  VerifyEmailView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/28/23.
//

import SwiftUI

struct VerifyEmailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm: LoginViewModel
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image("bigD")
                    .resizable()
                    .scaledToFit()
                .padding()
                
                HStack {
                    VStack(alignment:.leading) {
                        Text("Verify your Email")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Please enter the 4 digit code sent to\nyour@gmailcom")
                            .foregroundColor(.secondary)
                            .font(.caption)
                            .padding(.bottom)
                    }

                    Spacer()
                    
                }
                Spacer()
                
                VerificationComp()
                Button {
                    
                } label: {
                    Text("Resend Code")
                        .foregroundColor(.purple)
                        .padding()
                }
                
                Button {
                    withAnimation {
                        vm.verifyPop = true
                    }
                } label: {
                    LargeButtonComp(text: "Confirm")
                }
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Change Email")
                        .underline()
                        .foregroundColor(.purple)
                        .padding()
                }
            }
            .padding()
            if vm.verifyPop{
                PopUpVerificationComp()
                    .zIndex(1)
            }
        }
        .toolbar(.hidden)
        
        
    }
}

#Preview {
    VerifyEmailView()
        .environmentObject(LoginViewModel())
}
