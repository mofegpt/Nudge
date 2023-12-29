//
//  formInputComponent.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/28/23.
//

import SwiftUI

struct InputFormComp: View {
    @Binding var inputValue: String
    var placeholder :String
    var formTitle :String
    var body: some View {
        VStack(spacing: 0){
            TextField(placeholder, text: $inputValue)
                .font(.caption)
                .padding(.bottom)
                .background(Color(UIColor.systemBackground).opacity(0.0001))
            
            Divider()
                .frame(height: 1)
                .background(.purple)
        }
    }
}

#Preview {
    InputFormComp(inputValue: .constant(""), placeholder: "Username", formTitle: "Password")
}

#Preview {
    CreateAccountView()
}
