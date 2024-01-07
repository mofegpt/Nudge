//
//  CreateAccountView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/28/23.
//

import SwiftUI

struct CreateAccountView: View {
    @State var text: String = ""
    @EnvironmentObject var vm: LoginViewModel
    var body: some View {
        ZStack {
            
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        InputFormComp(inputValue: $vm.email, placeholder: " Email", formTitle: "Email")
                            .padding(.vertical)
                    
                        InputFormComp(inputValue: $vm.firstName, placeholder: "First Name", formTitle: "First Name")
                            .padding(.bottom)
                        InputFormComp(inputValue: $vm.lastName, placeholder: "Last Name", formTitle: "Last Name")
                            .padding(.bottom)
                        InputFormComp(inputValue: $vm.bio, placeholder: "Bio", formTitle: "Bio")
                            .padding(.bottom)
//                        InputFormComp(inputValue: $text, placeholder: "Confirm Password", formTitle: "Password")
//                            .padding(.bottom)
                    }
                    .padding(.horizontal)
                }
//                NavigationLink {
//                    VerifyEmailView()
//                } label: {
                    Button {
                        vm.createAccount()
                    } label: {
                        LargeButtonComp(text: "Verify Email")
                            .padding()
                    }
//
//                    
//                }
            }
            
            
        }
        .navigationTitle("Create Your Account")
        .navigationBarTitleDisplayMode(.large)
        
    }
}

#Preview {
    CreateAccountView()
        .environmentObject(LoginViewModel())
}
#Preview {
    LogInView()
}
