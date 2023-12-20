//
//  BioCompVeiw.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/17/23.
//

import SwiftUI

struct NudgeBioCompListView: View {
    var body: some View {
        
        NavigationLink {
            
        } label: {
            VStack {
                HStack {
                    VStack(alignment: .leading){
                        Text("20m")
                            .font(.caption)
                        Text("Lorem Ipsum")
                            .font(.largeTitle)
                            .foregroundStyle(.primary)
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. .")
                        
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
    NudgeBioCompListView()
}
#Preview {
    MapKitView()
}
