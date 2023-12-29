//
//  ProfileViewModel.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/25/23.
//

import Foundation
import SwiftUI


class ProfileViewModel: ObservableObject{
    let manager = CurrentUserService.instance
    let locationManager = LocationService.instance
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    
    func remove(){
       // locationManager.locationManager?.authorizationStatus = .notDetermined
    }
}
