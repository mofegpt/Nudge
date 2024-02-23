//
//  CurrentUserService.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/25/23.
//

import Foundation
import SwiftUI
import Firebase

class CurrentUserService: ObservableObject{
    @Published var currentUser: NudgerInfo?
    
    static let instance = CurrentUserService()
    
    init(){
        Task{
            try await fetchCurrentUser()
        }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let url = URL(string: "https://grouper-relieved-nearly.ngrok-free.app/userInfo?nudger_id=\(uid)") else { throw URLError(.badURL) }
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do{
            let decoder = JSONDecoder()
            let returnedUsers = try decoder.decode(NudgerInfo.self, from: data)
            self.currentUser = returnedUsers

        } catch{
            print("Could not decode JSON")
            throw URLError(.badServerResponse)
            
        }
        
    }
    
    func reset(){
        self.currentUser = nil
    }
    
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    @AppStorage("user_saved_data") private var appStorageData: Data = Data()
    
    private var UserData: AppStorageDataStruct {
        get {
            AppStorageDataStruct.fromData(appStorageData) ?? AppStorageDataStruct(nudgerID: "", firstName: "", lastName: "", email: "", bio: "", born: "", image: "")
        }
        set {
            switch newValue.toData() {
            case .success(let success):
                appStorageData = success
            case .failure(let failure):
                print("ERROR CONVERTING TO DATA FOR APPSTORAGE: \(failure)")
            }
        }
    }
    
    
    @AppStorage("email") var email: String = ""
    @AppStorage("first_name") var firstName: String = ""
    @AppStorage("last_name") var lastName: String = ""
    @AppStorage("nudger_id") var nudgerID: String = ""
    @AppStorage("bio") var bio: String = ""
    @AppStorage("born") var born: String = ""
    @AppStorage("image") var image: String = ""
    @AppStorage("hasCreatedAccount") var hasCreatedAccount: Bool?
    
    
    
    func updateAccountStatus(nudgerID: String, firstName: String, lastName: String, bio: String, image: String, born: String, email: String){
        UserData = AppStorageDataStruct(nudgerID: nudgerID , firstName: firstName, lastName: lastName, email: email, bio: bio, born: born, image: image)
    }
    
    func removeCurrentUser(){
        UserData = AppStorageDataStruct(nudgerID: "" , firstName: "", lastName: "", email: "", bio: "", born: "", image: "")
    }
    
    func getAppData() -> AppStorageDataStruct {
        return UserData
    }
    
}

struct AppStorageDataStruct: Codable{
    var nudgerID: String
    var firstName: String
    var lastName: String
    var email: String
    var bio: String
    var born: String
    var image: String
}
extension AppStorageDataStruct {
    // Convert struct to Data
    func toData() -> Result<Data, Error>{
        do{
            return .success(try JSONEncoder().encode(self))
        }catch let error{
            return .failure(error)
        }
    }
    
    // Convert Data back to struct
    static func fromData(_ data: Data) -> AppStorageDataStruct? {
        return try? JSONDecoder().decode(AppStorageDataStruct.self, from: data)
    }
}


