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
    let nearbyNudgers = NudgersAPIService.instance
    
    // LOCATION stuffs
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    // Holds the data of nearby users
    @Published var NearbyUsers: NearbyList?
    @Published var NearbyDetailedUsers: NearbyDetailedList?
    
    @Published var isNudgerSheetPresented = false
    @Published var isTapped = false
    
    // For annotation that are selected
    @Published var selectedNudger: String = "0"
    @Published var selectedNudgerDistance: Double = 0
    
    override init(){
        super.init()
        subscribeToRegion()
        subscribeToNearbyUsers()
        subscribeToNearbyDetailedUsers()
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
        }
    }
    
    func subscribeToRegion(){
        manager.$region
            .sink { [weak self] region in
                self?.cameraPosition = .region(region)
            }
            .store(in: &cancellable)
    }
    
    func subscribeToNearbyUsers(){
        nearbyNudgers.$nearbyNudgers
            .sink(receiveValue: { [weak self] results in
                self?.NearbyUsers = results
            })
            .store(in: &cancellable)
    }
    func subscribeToNearbyDetailedUsers(){
        nearbyNudgers.$nearbyDetailedList
            .sink(receiveValue: { [weak self] results in
                self?.NearbyDetailedUsers = results
            })
            .store(in: &cancellable)
    }
    
    func getNearbyUsers(){
        userLocation = manager.getUserLocation()
        nearbyNudgers.getNearbyNudgers(lon: userLocation?.longitude ?? 0, lat: userLocation?.latitude ?? 0) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print("ERROR DOWNLOADING NEARBY NUDGERS: \(failure.localizedDescription)")
            }
        }
        
    }
    
    func getDetailedNearbyUsers(){
        userLocation = manager.getUserLocation()
        nearbyNudgers.getDetailedNearbyNudgers(lon: userLocation?.longitude ?? 0, lat: userLocation?.latitude ?? 0) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print("ERROR DOWNLOADING DETAILED NEARBY NUDGERS: \(failure.localizedDescription)")
            }
        }
    }
    
}
 


