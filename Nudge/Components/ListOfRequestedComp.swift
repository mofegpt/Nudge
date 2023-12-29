//
//  ListOfRequestedComp.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/25/23.
//

import SwiftUI

struct ListOfRequestedComp: View {
    var body: some View {
        Image("simp")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.top,30)
            .overlay(alignment: .topLeading) {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing.")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    //.shadow(radius: 5)
                    .padding(.leading)
                    
            }
        Image("simp")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .frame(maxWidth: .infinity,alignment: .trailing)
            .padding(.top,30)
            .overlay(alignment: .topLeading) {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing.")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    //.shadow(radius: 5)
                    .padding(.trailing)
                    
            }
//            .padding()
//            .background(.purple)
//            .clipShape(RoundedRectangle(cornerRadius: 20))
//            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//            .overlay(alignment: .bottomTrailing) {
//                HStack {
//                    Image(systemName: "hand.thumbsdown.fill")
//                        .font(.largeTitle)
//                       // .foregroundStyle(.red)
//                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//                    Image(systemName: "hand.thumbsup.fill")
//                        .font(.largeTitle)
//                      //  .foregroundStyle(.green)
//                        .shadow(radius: 10)
//                }
//                .padding(.horizontal)
//            }
           // .background(.red)
    }
}

#Preview {
    ListOfRequestedComp()
}
