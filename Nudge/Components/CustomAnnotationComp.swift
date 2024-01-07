//
//  CustomAnnotationComp.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/17/23.
//

import SwiftUI

struct CustomAnnotationComp: View {
    @State private var isTapped = false
    //var image: UIImage
    @EnvironmentObject var mapData: MapUIKitViewModel
    var selectedNudger: NudgersStruct?
    var body: some View {
        VStack {
            Image("simp")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay(
                    Circle()
                        .stroke(.black, lineWidth: 3)
                )
            
            Circle()
                .frame(width: 5, height: 5)
        }
        .onTapGesture {
            withAnimation(.spring) {
            }
            mapData.isNudgerSheetPresented.toggle()
            mapData.selectedNudger = selectedNudger?.NudgerID ?? "0"
            mapData.selectedNudgerDistance = selectedNudger?.Distance ?? 0.0
        }
    }
}

#Preview {
    CustomAnnotationComp()
        .environmentObject(MapUIKitViewModel())
}
