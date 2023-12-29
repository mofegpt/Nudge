//
//  ProfileButtonCompView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/19/23.
//

import SwiftUI

struct ButtonRepComp: View {
    var name: String
    var body: some View {
        Image(systemName: name)
            .foregroundColor(.purple)
            .padding(20)
            .background(.ultraThickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}

#Preview {
    ButtonRepComp(name: "person.fill")
}
#Preview {
    MapKitView()
}
