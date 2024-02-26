//
//  LogInView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/28/23.
//

import SwiftUI
import GoogleSignInSwift

struct LogInView: View {
    @State var text: String = ""
        // @EnvironmentObject var vm: LoginViewModel
    @StateObject var vm = LoginViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bk")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 8)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Nudge")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                            //.foregroundStyle(.purple)
                        Spacer()
                    }
                    VStack(spacing: 5) {
                        
                        Spacer()
                        
                        TextField("Email", text: $vm.email)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $vm.password)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .autocapitalization(.none)

                        
                        

                        Button(action: {
                            vm.signIn()
                        }, label: {
                            Text("Sign In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.purple)
                            .cornerRadius(10)            })
//                        Button {
//                        //    vm.signIn()
//                        } label: {
//                            Text("Login with Google")
//                                .bold()
//                                .foregroundColor(.primary)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background()
//                                .cornerRadius(8)
//                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//                        }
                        
                        Spacer()
                        
                                               
                    }
                    .padding(.horizontal)
                    
                    ZStack {
                        Divider()
                            //.padding()
                        Text("OR")
                            .foregroundColor(Color(UIColor.lightGray))
                            .font(.caption)
                            .background(.opacity(0.00001))
                    }

                    NavigationLink {
                        CreateAccountView()
                    } label: {
                        HStack {
                            Text("New to the Platform? ")
                                .foregroundStyle(.secondary)
                            Text("Register")
                                .foregroundColor(.purple)
                        }
                        .padding()
                        .font(.footnote)
                        .bold()
                    }
                    
          
                    .navigationBarHidden(true)
                    
                }
            }
    }
        .tint(.purple)
        .environmentObject(vm)
    }
}

#Preview {
    LogInView()
      //  .environmentObject(LoginViewModel())
}
