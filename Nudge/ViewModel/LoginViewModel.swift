//
//  LoginViewModel.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/28/23.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class LoginViewModel: ObservableObject{
 //   var cancellable = Set<AnyCancellable>()
//    let manager = GoogleAuthService.instance
    let manager = AuthenticationManager.shared
    let apiManager = NudgersAPIService.instance
    let currentUserManager = CurrentUserService.instance
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    @Published var verifyPop: Bool = false
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var bio: String = ""
    @Published var userID: String = ""
    @Published var password: String = ""

    
    @Published var hasSignedIn: Bool = false
    init(){
     //   subscribeToNudgerInfo()
    }
    func signIn(){
        Task{
            do{
              let result  = try await manager.signIn(email: email, password: password)
                print("Success")
                print(result)

            } catch{
                print("Error: \(error)")

            }

        }
    }
    

    
//    func signOut(){
//        manager.signOut()
//    }
//    
//    func check(){
//        manager.check()
//    }
    
    func createAccount(){
        apiManager.createUser(nudgerID: userID, firstName: firstName, lastName: lastName, bio: "", image: "", born: "2003-05-30 23:59:59", email: email) {result in
            switch result {
            case .success(let success):
                print("Success: \(success)")
                self.currentUserManager.updateAccountStatus(nudgerID: self.userID, firstName: self.firstName, lastName: self.lastName, bio: self.bio, image: "", born: "20", email: "")
                self.currentUserManager.hasCreatedAccount = true
                self.currentUserManager.currentUserSignedIn = true
            case .failure(let failure):
                print("Failed: \(failure)")
            }
        }
    }
    
    
//    func subscribeToNudgerInfo(){
//        manager.$googleInfo
//            .sink(receiveValue: { [weak self] results in
//                self?.firstName = results?.FirstName ?? ""
//                self?.lastName = results?.LastName ?? ""
//                self?.email = results?.Email ?? "" // SHOULD NOT BE EMPTY
//                self?.userID = results?.UserId ?? "" // SHOULD NOT BE EMPTY
//            })
//            .store(in: &cancellable)
//    }
//    func subscribeToHasSignedIn(){
//        manager.$hasSignedIn
//            .sink(receiveValue: { results in
//                self.hasSignedIn = results
//                //self.currentUserManager.
//            })
//            .store(in: &cancellable)
//    }
}
