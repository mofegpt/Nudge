//
//  NearbyListAPIService.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/21/23.
//

import Foundation
import SwiftUI
import Combine


class NudgersAPIService{
    
    static let instance = NudgersAPIService()
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var nearbyNudgers: NearbyList?
    @Published var nearbyDetailedList: NearbyDetailedList?
    @Published var nudgerInfo: NudgerInfo?
    @Published var currentUser: NudgerInfo?
    
    
    func getNearbyNudgers(lon: Double, lat: Double, handler: @escaping (Result<String, Error>) -> ()){
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
                    handler(.success("COMPLETED SUCCESSFULLY"))
                    break
                case .failure(let error):
                    handler(.failure(error))
                    self.nearbyNudgers = nil
                }
            } receiveValue: { [weak self] (returnedUsers) in
                self?.nearbyNudgers = returnedUsers
            }
            .store(in: &cancellables)
    }
    
    func getDetailedNearbyNudgers(lon: Double, lat: Double, handler: @escaping (Result<String, Error>) -> ()){
        guard let url = URL(string: "http://localhost:8080/detailedNearbyUsers?longitude=\(lon)&latitude=\(lat)") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: NearbyDetailedList.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion{
                case .finished:
                    handler(.success("COMPLETED SUCCESSFULLY"))
                    break
                case .failure(let error):
                    handler(.failure(error))
                    self.nearbyDetailedList = nil
                }
            } receiveValue: { [weak self] (returnedUsers) in
                self?.nearbyDetailedList = returnedUsers
            }
            .store(in: &cancellables)
    }
    
    func getNudgerInfo(nudgerID: String, handler: @escaping (Result<String, Error>) -> ()){
        guard let url = URL(string: "http://localhost:8080/userInfo?id=\(nudgerID)") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: NudgerInfo.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion{
                case .finished:
                    handler(.success("COMPLETED SUCCESSFULLY"))
                    break
                case .failure(let error):
                    handler(.failure(error))
                    self.nudgerInfo = nil
                }
            } receiveValue: { [weak self] (returnedUsers) in
                self?.nudgerInfo = returnedUsers
            }
            .store(in: &cancellables)
    }
    
    enum NetworkError: Error {
        case badURL
        case requestFailed
    }
    
    struct Response: Codable{
        let message: String
    }
    
    
    
    func createUser(nudgerID: String, firstName: String, lastName: String, bio: String, image: String, born: String, email: String) async throws {
        guard let url = URL(string: "https://grouper-relieved-nearly.ngrok-free.app/userInfo") else { throw URLError(.badServerResponse) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: NudgerJSON = NudgerJSON(NudgerID: nudgerID, FirstName: firstName, LastName: lastName, Bio: bio, Age: born, Email: email, ImageBase64: image)
        
        do{
            request.httpBody = try JSONEncoder().encode(body)
        }
        catch{
            print("Could not decode JSON")
            throw URLError(.badServerResponse)
        }
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.requestFailed
            }
            Task{
                try await  CurrentUserService.instance.fetchCurrentUser()
                
            }
            
        } catch{
            print("Could parse data")
            throw URLError(.badServerResponse)
        }
        
        
    }
    
    
    
    func updateUser(nudgerID: String, firstName: String, lastName: String, bio: String, image: String, born: String, email: String, completion: @escaping (Result<String, NetworkError>) -> ()) {
        guard let url = URL(string: "http://localhost:8080/userInfo") else {
            completion(.failure(.badURL))
            return
        }
        print("lol")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: NudgerJSON = NudgerJSON(NudgerID: nudgerID, FirstName: firstName, LastName: lastName, Bio: bio, Age: born, Email: email, ImageBase64: image)
        
        do{
            request.httpBody = try JSONEncoder().encode(body)
        }
        catch let error {
            completion(.failure(.badURL))
            print("ERROR WITH HTTPBODY \(error)")
            return
        }
        
        // make the request
        let task = URLSession.shared.dataTask(with: request) { data , _, error in
            guard let data, error == nil else{
                DispatchQueue.main.async {
                    completion(.failure(.requestFailed))
                    print("Error: \(error.debugDescription)")
                }
                return
            }
            do{
                let response = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    //self.currentUser = response
                    completion(.success(response.message))
                    print("Success: \(response)")
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    completion(.failure(.requestFailed))
                    print("Error: \(error)")
                }
                return
            }
        }
        task.resume()
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


//    func createUser(nudgerID: String, firstName: String, lastName: String, bio: String, image: String, born: String, email: String, completion: @escaping (Result<String, NetworkError>) -> ()) {
//        guard let url = URL(string: "http://localhost:8080/userInfo") else {
//            completion(.failure(.badURL))
//            return
//        }
//        print("lol")
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let body: NudgerJSON = NudgerJSON(NudgerID: nudgerID, FirstName: firstName, LastName: lastName, Bio: bio, Age: born, Email: email, ImageBase64: image)
//
//        do{
//            request.httpBody = try JSONEncoder().encode(body)
//        }
//        catch let error {
//            completion(.failure(.badURL))
//            print("ERROR WITH HTTPBODY \(error)")
//            return
//        }
//
//        // make the request
//        let task = URLSession.shared.dataTask(with: request) { data , _, error in
//            guard let data, error == nil else{
//                DispatchQueue.main.async {
//                    completion(.failure(.requestFailed))
//                    print("Error: \(error.debugDescription)")
//                }
//                return
//            }
//            print("DEBUG: request made")
//            do{
//                let response = try JSONDecoder().decode(Response.self, from: data)
//                DispatchQueue.main.async {
//                    //self.currentUser = response
//                    completion(.success(response.message))
//                    print("Success: \(response)")
//                }
//            }
//            catch let error {
//                DispatchQueue.main.async {
//                    completion(.failure(.requestFailed))
//                    print("Error: \(error)")
//                }
//                return
//            }
//        }
//        task.resume()
//        Task{
//            try await  CurrentUserService.instance.fetchCurrentUser()
//
//        }
//
//    }
