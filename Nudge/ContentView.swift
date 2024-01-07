//
//  ContentView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 6/23/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("signed_in") var currentUserSignedIn: Bool  = false
    @AppStorage("hasCreatedAccount") var hasCreatedAccount = false
    @StateObject var vm = LoginViewModel()
    var body: some View {
        VStack {
            if !currentUserSignedIn{
                LogInView()
            }else{
                if !hasCreatedAccount {
                    CreateAccountView()
                }else{
                    MapKitView()
                }
               
               // MapKitView()
            }
        }.environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
