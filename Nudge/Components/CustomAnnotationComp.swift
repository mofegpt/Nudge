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
                //.scaleEffect(isTapped ? CGSize(width: 1.5, height: 1.5) : /*@START_MENU_TOKEN@*/CGSize(width: 1.0, height: 1.0)/*@END_MENU_TOKEN@*/ )
            
            Circle()
                .frame(width: 5, height: 5)
            //            Rectangle()
            //                .frame(width: 40, height: 40)
            //                .opacity(0)
        }
        //.background(.red)
        .onTapGesture {
            withAnimation(.spring) {
              //  isTapped.toggle()
             //   mapData.isNudgerSheetPresented.toggle()
            }
            mapData.isNudgerSheetPresented.toggle()
        }
    }
}

#Preview {
    CustomAnnotationComp()
        .environmentObject(MapUIKitViewModel())
}
