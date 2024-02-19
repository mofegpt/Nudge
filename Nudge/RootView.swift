//
//  RootView.swift
//  Nudge
//
//  Created by Dayo Iredele on 2/18/24.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewmodel = RootViewModel()
    var body: some View {
        Group{
            if viewmodel.userSession != nil {
                MapKitView()
            } else{
                LogInView()
            }
        }
        .environmentObject(CreateAccountViewModel())
    }
}

#Preview {
    RootView()
}
