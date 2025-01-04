//
//  Backyard_BirdsApp.swift
//  Backyard Birds
//
//  Created by Kasper Jonassen on 09/12/2024.
//

import SwiftUI
import Firebase

@main
struct Backyard_BirdsApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(BirdController())
                .environment(StateController())
                .environment(LocationManager())
        }
    }
}
