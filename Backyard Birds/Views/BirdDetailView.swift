//
//  BirdDetailView.swift
//  Backyard Birds
//
//  Created by Kasper Jonassen on 11/12/2024.
//

import SwiftUI
import Firebase
import MapKit

struct BirdDetailView: View {
    var bird: BirdDetected
    
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)

    
    var body: some View {
        ZStack {
            gradientBackground
            
            VStack(spacing: 16) {
                // Photo Block
                HStack {
                    Image(uiImage: bird.image?.imageFromBase64 ?? UIImage(systemName: "bird.fill")!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }
                // Specie Block
                HStack(spacing: 8) {
                    Text("Specie: \(bird.specie?.rawValue ?? "Bird")")
                        .font(.title)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)

                HStack(alignment: .top, spacing: 16) {
                    // Notes Block
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notes")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(bird.note)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
                }
                
                // Additional Info Block
                VStack(alignment: .leading, spacing: 8) {
                    Text("Additional Info")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Date: \(bird.date.formatted(date: .abbreviated, time: .shortened))")
                        Text("Location: \(bird.location.latitude), \(bird.location.longitude)")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(16)
                    .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal)
                
                // Map
                Map(position: $cameraPosition, interactionModes: [.all]) {
                    
                }
                .frame(height: 350)
                .cornerRadius(16)
                .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
            }
            .padding()
        }
    }
}

let dummyBird = BirdDetected(
    specie: .Crane,
    date: Date(),
    location: GeoPoint(latitude: 37.7749, longitude: -122.4194), // San Francisco
    note: "Spotted near the Golden Gate Bridge, appeared healthy and active.",
    image: "https://example.com/american_robin.jpg")

#Preview {
    BirdDetailView(bird: dummyBird)
}
