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
    @State var selectedDate: Date = Date()

    var body: some View {
        VStack {
            Text("When is your birthday?")
                .font(.largeTitle)
                .bold()

            DatePicker("Select a Date", selection: $vm.selectedDate, displayedComponents: .date)
                            .datePickerStyle(WheelDatePickerStyle())
                            .padding()

            
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
