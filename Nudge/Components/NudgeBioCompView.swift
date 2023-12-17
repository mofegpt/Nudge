//
//  BioCompVeiw.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/17/23.
//

import SwiftUI

struct NudgeBioCompView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment:.leading){
                    Text("20m")
                        .font(.caption)
                    Text("Lorem Ipsum")
                        .font(.largeTitle)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. .")
                        .font(.caption)
                }
                
                Image("simp")
                    .resizable()
                    .scaledToFill()
                    .frame(width:80, height: 80)
                    .cornerRadius(10)
                    .padding()
            }
            Divider()
                .padding(.vertical,10)
        }
    }
}

#Preview {
    NudgeBioCompView()
}
#Preview {
    MapKitView()
}
