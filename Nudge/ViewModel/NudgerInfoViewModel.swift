//
//  NudgerInfoViewModel.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/19/23.
//

import Foundation
import Combine


class NudgerInfoViewModel:NSObject, ObservableObject{
    var cancellable = Set<AnyCancellable>()
    let manager = NearbyListAPIService.instance
    @Published var Info: NudgerInfo?
    
    var interests: [NudgerInterest] = [NudgerInterest(NudgerID: 0, interest: "farming"),
                                               NudgerInterest(NudgerID: 1, interest: "farming"),
                                               NudgerInterest(NudgerID: 2, interest: "farming")]
    
    override init(){
        super.init()
        subscribeToNudgerInfo()
    }
    
    func getUser(id: Int){
        manager.getNudgerInfo(nudgerID: id)
        // NudgerInfo = NudgerInfoStruct(NudgerID: 9430, FirstName: "Madam", LastName: "Lisa", age: 25, Distance: "27", Bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", Interests: interests)
    }
    
    func subscribeToNudgerInfo(){
        manager.$nudgerInfo
            .sink(receiveValue: { [weak self] results in
                self?.Info = results ?? NudgerInfo(NudgerID: 0, FirstName: "", LastName: "", Bio: "", Image: "", Age: "0", Email: "", Interests: nil)
            })
            .store(in: &cancellable)
    }
}
