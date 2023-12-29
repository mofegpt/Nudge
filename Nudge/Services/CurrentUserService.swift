//
//  CurrentUserService.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/25/23.
//

import Foundation
import SwiftUI

class CurrentUserService{
    
    static let instance = CurrentUserService()
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    @AppStorage("email") var email: String = ""
    @AppStorage("first_name") var firstName: String = ""
    @AppStorage("last_name") var lastName: String = ""
    @AppStorage("nudger_id") var nudgerID: String = ""
    @AppStorage("bio") var bio: String = ""
    @AppStorage("born") var Date: String = ""
    @AppStorage("image") var image: String = ""
    
}
