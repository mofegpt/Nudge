//
//  ProfileViewModel.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/25/23.
//

import Foundation
import SwiftUI
import Combine


@MainActor
class ProfileViewModel: ObservableObject{
    
    let locationManager = LocationService.instance
    let currentUserManager = CurrentUserService.instance
    let apiManager = NudgersAPIService.instance
    let manager = AuthenticationManager.shared
    
//    @Published var currentUser: NudgerInfo = NudgerInfo(NudgerID: "", FirstName: "", LastName: "", Bio: "", Image: "", Age: "", Email: "")
    @Published var currentUser: NudgerInfo?
    @Published var profilePicture: UIImage? = nil
    @Published var imageUrl: String? = CurrentUserService.instance.currentUser?.Image ?? ""
    
   // private var cancellables = Set<AnyCancellable>()
    
    
    
    var cancellable = Set<AnyCancellable>()
    
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    @Published var userData: AppStorageDataStruct =  AppStorageDataStruct(nudgerID: "", firstName: "", lastName: "", email: "", bio: "", born: "", image: "")
    
    init() {
        Task{
           // await getCurrentUser()
            setupSubscribers()
        }
    }
    
    
    private func setupSubscribers(){
        CurrentUserService.instance.$currentUser.sink { user in
            self.currentUser = user
            print("DEBUG: User in view model from combine is \(String(describing: user))")
        }.store(in: &cancellable)
    }
    
    func remove(){
        // locationManager.locationManager?.authorizationStatus = .notDetermined
    }
    
    //    func signOut(){
    //        currentUserManager.currentUserSignedIn = false
    //        currentUserManager.hasCreatedAccount = false
    //        currentUserManager.removeCurrentUser()
    //    }
    
    
    @MainActor func signOut(){
        
        manager.signOut()
        print("signed Out")
        
    }
    
//    @MainActor func getCurrentUser() async {
//            guard let result = try? await apiManager.fetchCurrentUser(nudgerID: manager.userSession!.uid) else {return}
//            self.user = result
//            print(self.user)
//    }
    
    
    
    func loadImage() async{
      //  Task{
        let result =   try? await DownloadManager.instance.downloadImageFromURL(imageUrl: currentUser?.Image ?? "")
            self.profilePicture = result
      //  }
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
