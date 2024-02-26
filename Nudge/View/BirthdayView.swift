//
//  BirthdayView.swift
//  Nudge
//
//  Created by Dayo Iredele on 2/18/24.
//

import SwiftUI

struct BirthdayView: View {
  //  @ObservedObject private var vm: LoginViewModel()
    @EnvironmentObject var vm: CreateAccountViewModel
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button {
                print(vm.bio)
            } label: {
                Text("Click me")
            }

            Spacer()
            NavigationLink {
                ImageView()
            } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                    .cornerRadius(10)
            }
            

         //   .navigationBarHidden(true)
        }
        .padding(.horizontal)


    }
}

#Preview {
  
        
        BirthdayView()
    
}
