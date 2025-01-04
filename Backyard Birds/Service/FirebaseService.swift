//
//  FirebaseService.swift
//  Backyard Birds
//
//  Created by Kasper Jonassen on 11/12/2024.
//

import Foundation
import FirebaseFirestore

struct FirebaseService {
    private let dbCollection = Firestore.firestore().collection("BirdDetected")
    private var listner: ListenerRegistration?
    
    mutating func setUpListner(callback: @escaping ([BirdDetected])->Void) {
        listner = dbCollection.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            let birds = documents.compactMap{ queryDocumentSnapshot -> BirdDetected? in
                return try? queryDocumentSnapshot.data(as: BirdDetected.self)
            }
            callback(birds.sorted{$0.date < $1.date})
        }
    }
    
    mutating func tearDownListner() {
        listner?.remove()
        listner = nil
    }
    
    func addBird(bird: BirdDetected) {
        do {
            let _ = try dbCollection.addDocument(from: bird.self)
        } catch {
            print(error)
        }
    }
    
    func deleteBird(bird: BirdDetected) {
        guard let documentID = bird.id else { return }
        dbCollection.document(documentID).delete(){ error in
            if let error {
                print(error)
            }
        }
    }
}
