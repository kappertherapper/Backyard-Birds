//
//  Bird.swift
//  Backyard Birds
//
//  Created by Kasper Jonassen on 09/12/2024.
//

import Foundation
import CoreLocation
import FirebaseFirestore

struct BirdDetected: Codable, Identifiable {
    @DocumentID var id: String?
    let specie: Species?
    let date: Date
    let location: GeoPoint
    let note: String
    let image: String?
}

enum Species: String, Codable, Identifiable, CaseIterable {
    case Sparrow
    case Eagle
    case Hawk
    case Owl
    case Parrot
    case Robin
    case Pigeon
    case Falcon
    case Crow
    case Woodpecker
    case Penguin
    case Swan
    case Pelican
    case Flamingo
    case Heron
    case Duck
    case Crane
    case Seagull
    case Ostrich
    case Peacock
    case Bird
    
    var id: Self { self }
}
