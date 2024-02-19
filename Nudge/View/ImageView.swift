//
//  ImageView.swift
//  Nudge
//
//  Created by Dayo Iredele on 2/18/24.
//

import SwiftUI
import PhotosUI


struct ImageView: View {
    @EnvironmentObject private var vm: CreateAccountViewModel
    var body: some View {
        VStack (alignment: .leading) {
            //       VStack {
            Text("Pick your favorite picture.")
                .bold()
                .font(.largeTitle)
            //       }
            Spacer()
            
            VStack {
                //                Button(action: {
                //
                //
                //
                //                }, label: {
                //                    Text("+")
                //                        .font(.largeTitle)
                //                        .frame(width: 150, height: 150)
                //                        .foregroundColor(.black)
                //                        .background(Color.gray)
                //                        .cornerRadius(10)
                //                        .opacity(0.5)
                //                        .padding(.horizontal)                })
                
                PhotosPicker(selection: $vm.selectedImage) {
                    if let image = vm.profileImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else{
                        Text("+")
                            .font(.largeTitle)
                            .frame(width: 150, height: 150)
                            .foregroundColor(.black)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .opacity(0.5)
                            .padding(.horizontal)
                    }
                    
                }
                
                
            }
            .frame(maxWidth: .infinity)
            Spacer()
            
            Button(action: {
                Task{
                    do{
                        try await vm.imageToBase64()
                    }catch{
                        print("Error converting image: \(error)")
                    }
                    try await vm.register()
                }
            }, label: {
                LargeButtonComp(text: "Register")
                    .padding()
            })
            
          
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        //  .background(Color.purple)
    }
}

#Preview {
    ImageView()
}
