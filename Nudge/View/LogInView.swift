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
    @EnvironmentObject var vm: LoginViewModel
    var body: some View {
        NavigationView {
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
                        
                        Button {
                            vm.signIn()
                        } label: {
                            Text("Login with Google")
                                .bold()
                                .foregroundColor(.primary)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background()
                                .cornerRadius(8)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                        
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

                    
                    HStack {
                        Text("New to Nudge? ")
                            .foregroundStyle(.secondary)
                        Button {
                            vm.signOut()
                        } label: {
                            Text("Register")
                                .foregroundColor(.purple)
                        }
                    }
                    .padding()
                    .font(.footnote)
                    .bold()
                    .navigationBarHidden(true)
                }
            }
        }
        .tint(.purple)
    }
}

#Preview {
    LogInView()
        .environmentObject(LoginViewModel())
}
