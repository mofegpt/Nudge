//
//  InterestCompView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/19/23.
//

import SwiftUI

struct InterestCompView: View {
    var text: String
    var body: some View {
        Text(text)
            .padding(.horizontal,30)
            .padding(.vertical,10)
            .cornerRadius(30)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.primary, lineWidth: 1)
            }
    }
}

#Preview {
    InterestCompView(text: "farming")
}
