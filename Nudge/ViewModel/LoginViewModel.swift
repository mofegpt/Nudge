//
//  LoginViewModel.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/28/23.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject{
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    @Published var verifyPop: Bool = false
    
}
