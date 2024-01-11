//
//  pfTopComp.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/25/23.
//

import SwiftUI

struct PfTopComp: View {
    var firstName: String
    var lastName: String
    var age: String
    var body: some View {
        VStack(){
            ZStack {
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.purple)
                Circle()
                    .frame(width: 195, height: 195)
                    .foregroundColor(Color("wb"))
                Image("simp2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 190, height: 190)
                    .clipShape(Circle())
                    .foregroundStyle(.secondary)
                    
            }
            .overlay(alignment: .bottom) {
//                NavigationLink {
//                    
//                } label: {
//                    Text("Edit Profile")
//                        .bold()
//                        .foregroundStyle(Color("bw"))
//                        .padding(.vertical,10)
//                        .padding(.horizontal,50)
//                        .background(.purple)
//                        .clipShape(RoundedRectangle(cornerRadius: 30))
//                }
        }
            
            HStack(){
                Text("\(firstName), \(lastName)")
                    .font(.title)
                Text("\(age)")
            }
        }

    }
}

#Preview {
    PfTopComp(firstName: "Matthew", lastName: "faith", age: "26")
}
