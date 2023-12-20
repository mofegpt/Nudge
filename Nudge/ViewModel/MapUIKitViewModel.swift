//
//  MapUIKitViewModel.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 6/25/23.
//

import Foundation
import MapKit
import CoreLocation
import SwiftUI
import Combine

class MapUIKitViewModel:NSObject, ObservableObject, CLLocationManagerDelegate{
    var cancellable = Set<AnyCancellable>()
    let manager = LocationService.instance
    
    
    @Published var userLocation: CLLocationCoordinate2D?
    
    @Published var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    @Published var NudgersArray: [NudgersStruct] = [NudgersStruct(NudgerID: 0, smallImage: UIImage(named: "simp")!, Lat: 37.332294073368736, Lon: -122.03120840331954),
                                                    NudgersStruct(NudgerID: 1, smallImage: UIImage(named: "simp")!, Lat: 37.332289807949266, Lon: -122.03128349835336),
                                                    NudgersStruct(NudgerID: 2, smallImage: UIImage(named: "simp")!, Lat: 37.33240070877668, Lon: -122.03111989447063),
                                                    NudgersStruct(NudgerID: 3, smallImage: UIImage(named: "simp")!, Lat: 37.332311135044186, Lon: -122.03109575160634),]
    
    @Published var isNudgerSheetPresented = false
    @Published var isTapped = false
    
    override init(){
        super.init()
       subscribeToRegion()
    }
    // size of 2
    var lonAndLat = [CLLocationDegrees?](repeating: nil, count: 2)
    
    
    func getUserLocation(){
        userLocation = manager.getUserLocation()
        print(userLocation)
    }
    
    func updateRegion(){
        withAnimation(.default) {
            manager.updateMapRegion()
            //cameraPosition = .region(manager.region)
        }
    }
    
    func subscribeToRegion(){
        manager.$region
            .sink { [weak self] region in
                self?.cameraPosition = .region(region)
            }
            .store(in: &cancellable)
    }
    
}
 


