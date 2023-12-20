//
//  NudgersView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/17/23.
//

import SwiftUI

struct NudgersListView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0..<8) { _ in
                        NudgeBioCompView()
                            .padding(.horizontal) 
                }
                
            }
            
            .navigationTitle("Near by")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    NudgersListView()
}
