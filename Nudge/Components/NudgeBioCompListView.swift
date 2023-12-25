//
//  BioCompVeiw.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/17/23.
//

import SwiftUI

struct NudgeBioCompListView: View {
    var distance: Double
    var firstName: String
    var lastName: String
    var bio: String
    var body: some View {
        
        NavigationLink {
            
        } label: {
            VStack {
                HStack {
                    VStack(alignment: .leading){
                        Text(" \(distance.rounded().formatNumber())m")
                            .font(.caption)
                        Text("\(firstName) \(lastName)")
                            .font(.largeTitle)
                            .foregroundStyle(.primary)
                        Text("\(bio)")
                        
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    
                    Image("simp")
                        .resizable()
                        .scaledToFill()
                        .frame(width:80, height: 80)
                        .cornerRadius(10)
                }
                Divider()
            }
            
        }
        .buttonStyle(PlainButtonStyle())
        
    }
}

#Preview {
    NudgeBioCompListView(distance: 3.5,firstName:"RazzClart" ,lastName:"Bloodclart" , bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
}
#Preview {
    MapKitView()
}
