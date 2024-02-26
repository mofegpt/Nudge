//
//  largeButtonComp.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/28/23.
//

import SwiftUI

struct LargeButtonComp: View {
    var text: String
    var body: some View {
        Text(text)
            .bold()
            .foregroundColor(Color("bw"))
            .padding()
            .frame(maxWidth: .infinity)
            .background(.purple)
            .cornerRadius(10)
    }
}

#Preview {
    LargeButtonComp(text: "Verify email")
}
#Preview {
    LogInView()
}
