//
//  LocationService.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 6/25/23.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit

enum locationPermissionsEnum {
    case allow
    case notAllowed
    case restricted
    case denied
}


class LocationService: NSObject, CLLocationManagerDelegate {
    
    
    static let instance = LocationService()
    
    private override init(){}
    
    let regionAmount = { (location:  CLLocationCoordinate2D ) -> MKCoordinateRegion in
        MKCoordinateRegion(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
    }
    
    // Setting Region
    @Published var region: MKCoordinateRegion = .userRegion
    
    @Published var locationPermission: locationPermissionsEnum = .notAllowed
    
    
    // All about Locations part
    var locationManager: CLLocationManager?
    
    func checkIfLocationServiceIsEnabled(){
        DispatchQueue.global(qos: .userInitiated).async{
            if CLLocationManager.locationServicesEnabled(){
                DispatchQueue.main.async {
                    self.locationManager = CLLocationManager()
                    self.locationManager!.delegate = self
                    self.locationPermission = .allow
                }
            }else{
                DispatchQueue.main.async {
                    self.locationPermission = .notAllowed
                }
            }
        }
    }
    
    private func checkLocationAuthorization(){
        guard let locationManager = locationManager else { return }
        
        
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            print("not determined")
            locationManager.requestWhenInUseAuthorization()
            locationPermission = .allow
        case .restricted:
            print("restricted")
            locationPermission = .notAllowed
        case .denied:
            print("denied")
            locationPermission = .notAllowed
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = locationManager.location {
                self.region = regionAmount(location.coordinate)
                withAnimation(.default) {
                    updateMapRegion()
                }
            }
            locationPermission = .allow
        @unknown default:
            break
        }
        
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func updateMapRegion(){
        guard let locationManager = locationManager else { return }
        print("LOCATION PERMISSION: \(locationPermission)")
            if let location = locationManager.location {
                self.region = regionAmount(location.coordinate)
        }
    }
    
    func getUserLocation() -> CLLocationCoordinate2D?{
        guard let locationManager = locationManager?.location else { return nil }
        
            return locationManager.coordinate
    }
    
}


extension CLLocationCoordinate2D{
    static var userLocation: CLLocationCoordinate2D{
        return .init(latitude: 25.7602, longitude: -80.1959)
    }
}

extension MKCoordinateRegion{
    static var userRegion: MKCoordinateRegion{
        return .init(center: .userLocation,latitudinalMeters: 10000000,longitudinalMeters: 10000000)
    }
}
