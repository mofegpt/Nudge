//
//  FirebaseAuthService.swift
//  Nudge
//
//  Created by Dayo Iredele on 2/15/24.
//

import Foundation
import FirebaseAuth

@MainActor
final class AuthenticationManager: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    static let shared = AuthenticationManager()
    
    private init(){
        self.userSession = Auth.auth().currentUser
    }
    
    
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
//    func createUser(email:String, password:String) async throws -> AuthDataResultModel{
    func createUser(email:String, password:String) async throws {
        do{
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = authDataResult.user
//            try await CurrentUserService.instance.fetchCurrentUser()

        } catch{
            print("DEBUG: Failed to create user with error \(error.localizedDescription)") 
        }
       
   //     return AuthDataResultModel(user: self.userSession!)
        
           }
    
 //   func signIn(email:String, password:String) async throws -> AuthDataResultModel{
        func signIn(email:String, password:String) async throws{
            
            do{
                let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
                self.userSession = authDataResult.user
                try await CurrentUserService.instance.fetchCurrentUser()
                
                print("Success")
                
            } catch{
                print("DEBUG: Failed to sign in user with error \(error.localizedDescription)")
            }
            //      return AuthDataResultModel(user: self.userSession!)
        }
            
            
            
            func signOut(){
                try? Auth.auth().signOut()
                self.userSession = nil
                CurrentUserService.instance.reset()
            }
        }
    



struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}
