//
//  NudgersStruct .swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/17/23.
//

import Foundation
import CoreLocation
import SwiftUI

struct NudgersStruct: Codable, Identifiable{
    let id = UUID().uuidString
    let NudgerID: String
    let SmallImage: String
    let Lon: CLLocationDegrees
    let Lat: CLLocationDegrees
    let Distance: Double
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case NudgerID = "nudger_id"
        case SmallImage = "small_image"
        case Lon = "longitude"
        case Lat = "latitude"
        case Distance = "distance"
    }
}

struct NudgersDetailedStruct: Codable, Identifiable{
    let id = UUID().uuidString
    let NudgerID: String
    let FirstName: String
    let LastName: String
    let Bio: String
    let MediumImage: String
    let Distance: Double
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case NudgerID = "nudger_id"
        case FirstName = "first_name"
        case LastName = "last_name"
        case Bio = "bio"
        case MediumImage = "medium_image"
        case Distance = "distance"
    }
}

struct NearbyList: Codable{
    let nearbyNudgers: [NudgersStruct]
    enum CodingKeys: String, CodingKey {
        case nearbyNudgers = "nearby_users"
    }
}

struct NearbyDetailedList: Codable{
    let nearbyNudgers: [NudgersDetailedStruct]
    enum CodingKeys: String, CodingKey {
        case nearbyNudgers = "nearby_detailed_list"
    }
}


struct NudgerInfo: Codable{
   // let id = UUID().uuidString
    var NudgerID: String
    var FirstName: String
    var LastName: String
    var Bio: String
    var Image: String
    var Age: String
    var Email: String

//    let ImageBase64: String
//    let Interests: [NudgerInterest]?
    
    enum CodingKeys: String, CodingKey {
        case NudgerID = "nudger_id"
        case FirstName = "first_name"
        case LastName = "last_name"
        case Bio = "bio"
        case Image = "image_path"
        case Age = "age"
        case Email = "email"
 //       case ImageBase64 = "image_base64"
//        case Interests = "interests"
    }
    
}

struct NudgerInterest: Codable, Identifiable{
    let id = UUID().uuidString
    let NudgerID: String
    let interest: String
    enum CodingKeys: String, CodingKey {
        case NudgerID = "nudger_id"
        case interest = "interest"
    }
}

struct NudgerJSON: Codable{
    let NudgerID: String
    let FirstName: String
    let LastName: String
    let Bio: String
    let Age: String
    let Email: String
    let ImageBase64: String
    
    enum CodingKeys: String, CodingKey {
        case NudgerID = "nudger_id"
        case FirstName = "first_name"
        case LastName = "last_name"
        case Bio = "bio"
        case Age = "age"
        case Email = "email"
        case ImageBase64 = "image_base64"
    }
    
}

struct UpdateNudgerJSON: Codable{
    let NudgerID: String
//    let FirstName: String
//    let LastName: String
    var Bio: String
//    let Age: String
//    let Email: String
//    let ImageBase64: String
    
    enum CodingKeys: String, CodingKey {
        case NudgerID = "nudger_id"
//        case FirstName = "first_name"
//        case LastName = "last_name"
        case Bio = "bio"
//        case Age = "age"
//        case Email = "email"
//        case ImageBase64 = "image_base64"
    }
    
}

