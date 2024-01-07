//
//  GoogleAuthService.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 1/2/24.
//

import Foundation
import SwiftUI
import GoogleSignIn


class GoogleAuthService{
    
    static let instance = GoogleAuthService()
    //@AppStorage("signed_in") var currentUserSignedIn: Bool  = false
    let currentUserManager = CurrentUserService.instance
//
//    @Published var givenName: String = ""
//    @Published var profilePicUrl: String = ""
//    @Published var isLoggedIn: Bool = false
//    @Published var errorMessage: String = ""
//    @Published var userID: String = ""
//    
    @Published var googleInfo: GoogleInfo? = nil
    @Published var hasSignedIn: Bool = false
    
    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil){
            guard let user = GIDSignIn.sharedInstance.currentUser else { return }
            
            // profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
            // USERID SHOULD NOT BE EMPTY
            self.googleInfo = GoogleInfo(UserId: user.userID!, Image: "", FirstName: user.profile?.name ?? "", LastName: user.profile?.familyName ?? "", Email: user.profile!.email)
            currentUserManager.currentUserSignedIn = true
            hasSignedIn = true
            print("UserID: \(user.userID!)")
        }else{
            currentUserManager.currentUserSignedIn = false
        }
    }
    
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
               // self.errorMessage = "error: \(error.localizedDescription)"
                print("Error: \(error.localizedDescription)")
            }
            
            self.checkStatus()
        }
    }
    
    func signIn(){
        
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { user, error in
            if let error = error{
                //self.errorMessage = "error: \(error.localizedDescription)"
                print("Error: \(error.localizedDescription)")
            }
            self.checkStatus()
        }
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
}


struct GoogleInfo{
    let UserId: String
    let Image: String
    let FirstName: String
    let LastName: String
    let Email: String
}
