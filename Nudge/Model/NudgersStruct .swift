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
    let NudgerID: Int
    let SmallImage: String
    let Lon: CLLocationDegrees
    let Lat: CLLocationDegrees
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case NudgerID = "nudger_id"
        case SmallImage = "small_image"
        case Lon = "longitude"
        case Lat = "latitude"
    }
}

struct NudgersDetailedStruct: Codable, Identifiable{
    let id = UUID().uuidString
    let NudgerID: Int
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


struct NudgerInfoStruct:Identifiable{
    public var id = UUID().uuidString
    public var NudgerID: Int?
    public var FirstName: String?
    public var LastName: String?
    public var age: Int?
    public var Distance: String?
    public var Bio: String?
    public var Interests: [NudgerInterest]?
    
}

struct NudgerInterest: Identifiable{
    public var id = UUID().uuidString
    public var NudgerID: Int
    public var interest: String
}
