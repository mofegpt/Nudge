//
//  LogInView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/28/23.
//

import SwiftUI

struct LogInView: View {
    @State var text: String = ""
    @StateObject var vm = LoginViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Image("bk")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 8)
                    .ignoresSafeArea()
                VStack{
                    VStack {
                        VStack(spacing: 0){
                            Text("Email")
                                .foregroundColor(.purple)
                                .bold()
                                .font(.system(size: 12))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            TextField("", text: $text)
                                .padding()
                                .background(.secondary)
                                .cornerRadius(16)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.purple, lineWidth: 1)
                                }
                            
                        }
                        
                        Spacer()
                            .frame(maxHeight: 20)
                        VStack(spacing: 0){
                            Text("Password")
                                .foregroundColor(.purple)
                                .bold()
                                .font(.system(size: 12))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            TextField("", text: $text)
                                .padding()
                                .background(.secondary)
                                .cornerRadius(16)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.purple, lineWidth: 1)
                                }
                            HStack {
                                Spacer()
                                Button {
                                    //loginvm.checkIfUserExist()
                                } label: {
                                    Text("Log in")
                                        .foregroundColor(.purple)
                                        .underline()
                                        //.bold()
                                }
                                .padding(.vertical)
                            }
                        }
                        
                    }
                    .padding(.horizontal)
                }
                VStack {
                    Spacer()
                    ZStack {
                        Divider()
                            .padding()
                        Text("OR")
                            .foregroundColor(Color(UIColor.lightGray))
                            .font(.caption)
                            .background(.opacity(0.00001))
                    }
                    
                    NavigationLink {
                        CreateAccountView()
                    } label: {
                        LargeButtonComp(text: "Create Account")
                            .padding([.horizontal,.bottom])
                    }
                }
                
                .navigationBarHidden(true)
            }
        }
        .tint(.purple)
        .environmentObject(vm)
    }
}

#Preview {
    LogInView()
}
