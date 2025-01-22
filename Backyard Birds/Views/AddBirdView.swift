//
//  AddBirdView.swift
//  Backyard Birds
//
//  Created by Kasper Jonassen on 11/12/2024.
//

import SwiftUI
import MapKit
import PhotosUI
import Firebase



struct AddBirdView: View {
    @Environment(LocationManager.self) private var locationManager
    @Environment(BirdController.self) private var birdController
    @Environment(StateController.self) private var stateController
    @Environment(\.dismiss) var dismiss
    
    @State private var specie: Species? = .Bird
    @State private var date: Date = Date.now
    @State private var note: String = ""
    @State private var location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @State private var birdImage: UIImage?
    @State private var selection: PhotosPickerItem?
    
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    
    var body: some View {
        ZStack {
            gradientBackground
            
            VStack(spacing: 16) {
                // Photo
                HStack() {
                    PhotosPicker(selection: $selection, matching: .images) {
                        Image(uiImage: birdImage ?? UIImage(systemName: "bird.fill")!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    }
                }
                // Specie & Note Block
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Choose a specie:")
                            .font(.headline)
                        Picker("Species", selection: $specie) {
                            ForEach(Species.allCases) { species in
                                Text(species.rawValue).tag(Optional(species))
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    TextField("Enter a note", text: $note)
                        .padding(10)
                        .background(Color(UIColor.systemGray6).opacity(0.9))
                        .cornerRadius(10)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.8))
                .cornerRadius(16)
                .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
                
                // Additional Info Block
                VStack(alignment: .leading, spacing: 8) {
                    Text("Additional Info")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Date: \(date.formatted(date: .abbreviated, time: .shortened))")
                            .padding(.vertical, 2)
                        
                        Text("Location: \(location.latitude), \(location.longitude)")
                            .padding(.vertical, 2)
                    }
                    
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(16)
                    .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
                }
                
                Spacer()
                
                // Map
                Map(position: $cameraPosition) {
                    
                }
                
                Spacer()
                
                // Add Button
                Button(action: {
                    let base64 = birdImage?.base64
                    
                    birdController.add(bird: BirdDetected(
                        specie: specie ?? .Crow,
                        date: date,
                        location: location.toGeoPoint(),
                        note: note,
                        image: base64))
                    
                    dismiss()
                }) {
                    Text("Add Bird")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding()
        }
        .onAppear {
            locationManager.startLocationUpdates()
        }
            .onChange(of: locationManager.lastLocation) {
                location = locationManager.lastLocation.coordinate
            }
            .onChange(of: selection) { _, _ in
                Task {
                    if let selection,
                       let data = try? await selection.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            birdImage = image
                        }
                    }
                    selection = nil
                }
            }
        }
    }

#Preview {
    AddBirdView()
        .environment(BirdController())
        .environment(LocationManager())
        .environment(StateController())
}
