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
            .font(.callout)
            .padding(.horizontal,30)
            .padding(.vertical,10)
            .cornerRadius(30)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.primary, lineWidth: 1)
                    .foregroundStyle(AngularGradient(gradient: Gradient(colors: [.purple, .gray, .purple, .gray]), center: .center))
            }
    }
}

#Preview {
    InterestCompView(text: "farming")
}
