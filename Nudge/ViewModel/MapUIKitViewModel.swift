//
//  MapUIKitViewModel.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 6/25/23.
//

import Foundation
import MapKit
import CoreLocation

class MapUIKitViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    let manager = LocationService.instance
    
    // size of 2
    var lonAndLat = [CLLocationDegrees?](repeating: nil, count: 2)
    
    func getUserLocation(){
        let result = manager.getLocation()
        lonAndLat[0] = result.0
        lonAndLat[1] = result.1
        print(lonAndLat)
    }
}
 
