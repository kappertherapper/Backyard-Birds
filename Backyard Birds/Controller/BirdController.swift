//
//  BirdController.swift
//  Backyard Birds
//
//  Created by Kasper Jonassen on 11/12/2024.
//

import SwiftUI

@Observable
class BirdController {
    var birds = [BirdDetected]()
    
    @ObservationIgnored
    private var firebaseService = FirebaseService()
    
    init() {
        firebaseService.setUpListner { fetchedUsers in
            self.birds = fetchedUsers
        }
    }
    
    func update(bird: BirdDetected){ }
    
    func delete(bird: BirdDetected){
        firebaseService.deleteBird(bird: bird)
    }
    
    func add(bird: BirdDetected){
        firebaseService.addBird(bird: bird)
    }
}
