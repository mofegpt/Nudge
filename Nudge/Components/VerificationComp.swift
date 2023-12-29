//
//  formVerficationComp.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/28/23.
//

import SwiftUI

struct VerificationComp: View {
    @State var text1: String = ""
    @State var text2: String = ""
    @State var text3: String = ""
    @State var text4: String = ""

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 11)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .overlay(alignment: .leading) {
                    HStack(spacing:1){
                        box(text: $text1)
                        box(text: $text2)
                        box(text: $text3)
                        box(text: $text4)
                    }
                    .cornerRadius(10)
                    .padding(.vertical,1)
                    .padding(.horizontal,1)
                   
                }
        }
    }
    
    func box (text: Binding<String>) -> some View{
        ZStack {
            Rectangle()
                .foregroundColor(Color("bw"))
            
                TextField("_", text: text).multilineTextAlignment(.center)
                    .frame(width: 25, height: 10)
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    VerificationComp()
}
