//
//  NudgeApp.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 6/23/23.
//

import SwiftUI
import Firebase

@main
struct NudgeApp: App {
    init(){
        FirebaseApp.configure()
        print("Configured Firebase!")
    }
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
