//
//  ProfileViewModel.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/25/23.
//

import Foundation
import SwiftUI
import Combine


class ProfileViewModel: ObservableObject{
    var cancellable = Set<AnyCancellable>()
    let locationManager = LocationService.instance
    let currentUserManager = CurrentUserService.instance
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    @Published var userData: AppStorageDataStruct =  AppStorageDataStruct(nudgerID: "", firstName: "", lastName: "", email: "", bio: "", born: "", image: "")
    
    func remove(){
       // locationManager.locationManager?.authorizationStatus = .notDetermined
    }
    
    func signOut(){
        currentUserManager.currentUserSignedIn = false
        currentUserManager.hasCreatedAccount = false
        currentUserManager.removeCurrentUser()
    }
    
    func getAppData(){
        userData = currentUserManager.getAppData()
    }
}
