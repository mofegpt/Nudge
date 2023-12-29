//
//  ContentView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 6/23/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("signed_in") var currentUserSignedIn: Bool  = false
    var body: some View {
        VStack {
            if (!currentUserSignedIn){
                LogInView()
            }else{
                MapKitView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
