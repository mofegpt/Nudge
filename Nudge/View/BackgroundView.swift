//
//  UserInfoView.swift
//  Nudge
//
//  Created by Dayo Iredele on 2/21/24.
//

import SwiftUI
import Kingfisher


struct BackgroundView: View {
    @State private var showSheet = true
    @StateObject var vm = ProfileViewModel()


    var body: some View {
        VStack {
            VStack {
                KFImage(URL(string: vm.imageUrl ?? "1"))
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: 500)
            
            Spacer()
            
                .sheet(isPresented: $showSheet, content: {
                UserInfoView()
                        .presentationDetents([.fraction(0.4), .large])
                        .interactiveDismissDisabled()
                        .presentationBackgroundInteraction(.enabled(upThrough: .large))
                
                })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environmentObject(vm)
    }
}

#Preview {
    UserInfoView()
}
