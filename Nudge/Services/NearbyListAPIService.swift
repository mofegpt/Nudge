//
//  NearbyListAPIService.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/21/23.
//

import Foundation
import SwiftUI
import Combine


class NearbyListAPIService{
    
    static let instance = NearbyListAPIService()
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var nearbyNudgers: NearbyList?
    @Published var nearbyDetailedList: NearbyDetailedList?
    @Published var nudgerInfo: NudgerInfo?
    
    
    func getNearbyNudgers(lon: Double, lat: Double){
        guard let url = URL(string: "http://localhost:8080/nearbyUsers?longitude=\(lon)&latitude=\(lat)") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: NearbyList.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print("ERROR DOWNLOADING NEARBY NUDGERS: \(error)")
                    self.nearbyNudgers = nil
                }
            } receiveValue: { [weak self] (returnedUsers) in
                self?.nearbyNudgers = returnedUsers
            }
            .store(in: &cancellables)
    }
    
    func getDetailedNearbyNudgers(lon: Double, lat: Double){
        guard let url = URL(string: "http://localhost:8080/detailedNearbyUsers?longitude=\(lon)&latitude=\(lat)") else { return }
        var request = URLRequest(url: url)
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: NearbyDetailedList.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print("ERROR DOWNLOADING DETAILED NEARBY NUDGERS: \(error)")
                    self.nearbyDetailedList = nil
                }
            } receiveValue: { [weak self] (returnedUsers) in
                self?.nearbyDetailedList = returnedUsers
            }
            .store(in: &cancellables)
    }
    
    func getNudgerInfo(nudgerID: Int){
        guard let url = URL(string: "http://localhost:8080/getUserInfo?id=\(nudgerID)") else { return }
        var request = URLRequest(url: url)
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: NudgerInfo.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print("ERROR DOWNLOADING NUDGER INFO: \(error)")
                    self.nudgerInfo = nil
                }
            } receiveValue: { [weak self] (returnedUsers) in
                self?.nudgerInfo = returnedUsers
            }
            .store(in: &cancellables)
    }
    
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data{
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else{
            print("URL REQUEST WAS NOT SUCCESSFULL")
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }

}
