//
//  NearbyNudgerCard.swift
//  Nudge
//
//  Created by Dayo Iredele on 2/22/24.
//

import SwiftUI

struct NearbyNudgerCard: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                HStack(alignment: .top){
                    Image("eve")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                        .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 15)
                    VStack{
                        //   Text("Maria Flah")
                        Text("Eve Adeola")
                            .font(.headline)
                        Text("24 min ago")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                    
                }
                .frame(maxWidth: .infinity)
                
                Text("This is a cool place to be. Nice to see you.")
                
            }
            .frame(height: 60)
            .frame(width: 210)
            .padding(.vertical, 40)
            .padding(.horizontal, 30)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        
        .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 3)
        .padding()
    }
}

#Preview {
    NearbyNudgerCard()
}
