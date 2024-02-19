//
//  CreateAccountViewModel.swift
//  Nudge
//
//  Created by Dayo Iredele on 2/18/24.
//

import Foundation
import PhotosUI
import SwiftUI

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
    
    func register() async throws{
        let result = try await  manager.createUser(email: email, password: password)
        print("user id: \(result.uid)")
        
        apiManager.createUser(nudgerID: result.uid, firstName: firstName, lastName: lastName, bio: bio, image: image, born: "2003-05-30 23:59:59", email: email) {result in
            
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
        // let json: [String: Any] = ["image": base64Image]
        image = base64Image
        
        
    }
}




