//
//  PopUpVerificationComp.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/28/23.
//

import SwiftUI

struct PopUpVerificationComp: View {
    @EnvironmentObject var vm: LoginViewModel
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    withAnimation {
                       vm.verifyPop = false
                    }
                }
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("bw"))
                    .padding(.vertical,180)
                VStack(spacing:0){
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.purple)
                    Text("Verified!")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    Text("Yahoo! You have successfully verified the account.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .font(.callout)
                    Button {
                        vm.currentUserSignedIn = true
                    } label: {
                        LargeButtonComp(text: "Go to Dashboard")
                            .padding(.vertical)
                            .padding(.horizontal,80)
                    }
                }
            }
            .padding()
            
            
            .toolbar(.hidden)
        }
    }
}

#Preview {
    PopUpVerificationComp()
        .environmentObject(LoginViewModel())
}
