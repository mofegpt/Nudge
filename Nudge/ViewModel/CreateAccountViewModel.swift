//
//  CreateAccountViewModel.swift
//  Nudge
//
//  Created by Dayo Iredele on 2/18/24.
//

import Foundation
import PhotosUI
import SwiftUI
import Combine

@MainActor
class CreateAccountViewModel: ObservableObject{
    let manager = AuthenticationManager.shared
    let apiManager = NudgersAPIService.instance
    @Published var selectedImage: PhotosPickerItem? {
        didSet{
            Task{
                
                await loadImage()
            }
        }
    }
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var bio: String = ""
    @Published var userID: String = ""
    @Published var password: String = ""
    @Published var image: String = ""
    @Published var profileImage: Image?
    @Published var currentUser: NudgerInfo?
    
    
    
    init() {
        
    }
    
    func register() async throws{
        try await  manager.createUser(email: email, password: password)
        //      print("user id: \(String(describing: manager.userSession?uid))")
        guard let id = manager.userSession?.uid else {return}
        
        do{
            try await apiManager.createUser(nudgerID: id, firstName: firstName, lastName: lastName, bio: bio, image: image, born: "2003-05-30 23:59:59", email: email)
        }catch{
            print("DEBUG: Could not create user")
        }
        
    }
    
    
    private func loadImage() async {
        guard let item = selectedImage else {return}
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.profileImage = Image(uiImage: uiImage)
    }
    
    
    func imageToBase64() async throws {
        guard let item = selectedImage else {return}
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        
        guard let imageData = uiImage.jpegData(compressionQuality: 0.25) else { return}
        
        let base64Image = imageData.base64EncodedString()
        print("DEBUG: image converted")
        image = base64Image
 
    }
    
}




