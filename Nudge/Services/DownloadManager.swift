//
//  DownloadManager.swift
//  Nudge
//
//  Created by Dayo Iredele on 2/20/24.
//

import Foundation
import SwiftUI

class DownloadManager{
    
    static let instance = DownloadManager()
    
    
    
    func downloadImageFromURL (imageUrl: String) async throws -> UIImage{
        guard let url = URL(string: imageUrl) else {throw URLError(.badURL)}
        var image = UIImage()
        do{
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            let result = UIImage(data: data)
            image = result!
        } catch{
            print("DEBUG: Failed to download image with this error \(error)")
        }
        
        return image
    }
}
