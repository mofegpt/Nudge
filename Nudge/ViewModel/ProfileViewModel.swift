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
    let apiManager = NudgersAPIService.instance
    
    
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
    
    // updates the database and app storage
    func updateData(fName: String, lName: String, bio: String, image: String, born: String){
        apiManager.updateUser(nudgerID: userData.nudgerID, firstName: fName, lastName: lName, bio: bio, image: image, born: "2003-05-30 23:59:59", email: self.userData.email) { result in
            switch result {
            case .success(let success):
                print("\(success)")
                self.currentUserManager.updateAccountStatus(nudgerID: self.userData.nudgerID, firstName: fName, lastName: lName, bio: bio, image: "", born: "20", email: self.userData.email)
                self.getAppData()
            case .failure(let failure):
                print("Updating Failed: \(failure)")
            }
        }
    }
}
