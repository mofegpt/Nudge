//
//  RootViewModel.swift
//  Nudge
//
//  Created by Dayo Iredele on 2/18/24.
//

import Foundation
import Firebase
import Combine

@MainActor
class RootViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    init(){
        setupSubscribers()
    }
    
    private func setupSubscribers(){
            AuthenticationManager.shared.$userSession.sink { [weak self] userSession in
                self?.userSession = userSession
            }.store(in: &self.cancellables)
        }
       
    }
    

