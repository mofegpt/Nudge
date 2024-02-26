//
//  CreateAccountView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/28/23.
//

import SwiftUI

struct CreateAccountView: View {
  //  @State var text: String = ""
  //  @EnvironmentObject var vm: LoginViewModel
    @EnvironmentObject private var vm: CreateAccountViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
            VStack {
            //    ScrollView {
                    VStack(spacing: 20) {
                        InputFormComp(inputValue: $vm.newUser.Email, placeholder: " Email", formTitle: "Email")
                            .padding(.vertical)
                        
                        InputFormComp(inputValue: $vm.password, placeholder: " Password", formTitle: "Password")
                            .padding(.vertical)
                    
                        InputFormComp(inputValue: $vm.newUser.FirstName, placeholder: "First Name", formTitle: "First Name")
                            .padding(.bottom)
                        InputFormComp(inputValue: $vm.newUser.LastName, placeholder: "Last Name", formTitle: "Last Name")
                            .padding(.bottom)
                        InputFormComp(inputValue: $vm.newUser.Bio, placeholder: "Bio", formTitle: "Bio")
                            .padding(.bottom)
//                        InputFormComp(inputValue: $text, placeholder: "Confirm Password", formTitle: "Password")
//                            .padding(.bottom)
                    }
                    .padding(.horizontal)
                Spacer()
              //  }
//                NavigationLink {
//                    VerifyEmailView()
//                } label: {
                
                NavigationLink {
                    BirthdayView()
                } label: {
                        LargeButtonComp(text: "Continue")
                            .padding()
                    
                }


                HStack {
                    Text("Already have an account? ")
                        .foregroundStyle(.secondary)
                    Button {
                        dismiss()
                    } label: {
                        Text("Sign in")
                            .foregroundColor(.blue)
                    }
                    
                }
//
//                    
//                }
            }
                    .navigationTitle("Create Your Account")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarHidden(true)
          //          .environmentObject(vm)

   //     }
        
        
    }
        

}

#Preview {
    
        CreateAccountView()
         //      .environmentObject(LoginViewModel())
    
   
}
//#Preview {
//    LogInView()
//}