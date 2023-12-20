//
//  ProfileButtonCompView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/19/23.
//

import SwiftUI

struct ProfileButtonCompView: View {
    var body: some View {
        Image(systemName: "person.fill")
            .padding(13)
            .background(.ultraThickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}

#Preview {
    ProfileButtonCompView()
}
#Preview {
    MapKitView()
}
