//
//  NudgerInfoViewModel.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/19/23.
//

import Foundation


class NudgerInfoViewModel:NSObject, ObservableObject{
    
    @Published var NudgerInfo: NudgerInfoStruct = NudgerInfoStruct()
    
    private var interests: [NudgerInterest] = []
    
    override init(){
        super.init()
        getUser()
    }
    
    func getUser(){
        interests = [NudgerInterest(NudgerID: 0, interest: "farming"),
                     NudgerInterest(NudgerID: 1, interest: "farming"),
                     NudgerInterest(NudgerID: 2, interest: "farming")]
        
        NudgerInfo = NudgerInfoStruct(NudgerID: 9430, FirstName: "Madam", LastName: "Lisa", age: 25, Distance: "27", Bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", Interests: interests)
    }
}
