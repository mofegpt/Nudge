//
//  pfTopComp.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/25/23.
//

import SwiftUI
import Kingfisher

struct PfTopComp: View {
    var firstName: String
    var lastName: String
    var age: String
    
 //   var user: NudgerInfo?
    @Binding var profilePicture: String?
    var body: some View {
        VStack(){
            ZStack {
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.purple)
                Circle()
                    .frame(width: 195, height: 195)
                    .foregroundColor(Color("wb"))
                if let imageUrl = profilePicture{
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 190, height: 190)
                        .clipShape(Circle())

                }else{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 190, height: 190)
                        .clipShape(Circle())
                        .foregroundStyle(.gray)
                        
                }
                
                    
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

//#Preview {
//    PfTopComp(firstName: "Matthew", lastName: "faith", age: "26", profilePicture: "simp")
//}
