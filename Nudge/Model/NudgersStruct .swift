//
//  NudgersStruct .swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/17/23.
//

import Foundation
import CoreLocation
import SwiftUI

struct NudgersStruct: Identifiable{
    public var id = UUID().uuidString
    public var NudgerID: Int
    public var smallImage: UIImage
    public var Lat: CLLocationDegrees
    public var Lon: CLLocationDegrees
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
