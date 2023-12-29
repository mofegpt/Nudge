//
//  CreateAccountView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/28/23.
//

import SwiftUI

struct CreateAccountView: View {
    @State var text: String = ""
    var body: some View {
        ZStack {
            
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        InputFormComp(inputValue: $text, placeholder: " Email", formTitle: "Email")
                            .padding(.vertical)
                    
                        InputFormComp(inputValue: $text, placeholder: "First Name", formTitle: "First Name")
                            .padding(.bottom)
                        InputFormComp(inputValue: $text, placeholder: "Last Name", formTitle: "Last Name")
                            .padding(.bottom)
                        InputFormComp(inputValue: $text, placeholder: "Password", formTitle: "Password")
                            .padding(.bottom)
                        InputFormComp(inputValue: $text, placeholder: "Confirm Password", formTitle: "Password")
                            .padding(.bottom)
                    }
                    .padding(.horizontal)
                }
                NavigationLink {
                    VerifyEmailView()
                } label: {
                    LargeButtonComp(text: "Verify Email")
                        .padding()
                }
            }
            
            
        }
        .navigationTitle("Create Your Account")
        .navigationBarTitleDisplayMode(.large)
        
    }
}

#Preview {
    CreateAccountView()
}
#Preview {
    LogInView()
}
