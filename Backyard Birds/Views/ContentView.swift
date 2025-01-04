//
//  ContentView.swift
//  Backyard Birds
//
//  Created by Kasper Jonassen on 09/12/2024.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @Environment(BirdController.self) private var birdController
    @Environment(StateController.self) private var stateController
    @Environment(LocationManager.self) private var locationManager
    
    @State private var showQuote = false
    @State private var showAddBirdView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                gradientBackground
                
                VStack {
                    HStack {
                        // Sort Button (Specie)
                        Button(action: {
                            birdController.birds.sort { ($0.specie?.rawValue ?? "Bird") < ($1.specie?.rawValue ?? "Bird") }
                        }) {
                            Text("Sort by species")
                                .fontWeight(.bold)
                                .padding(.horizontal, 20)
                        }
                        // Sort Button (Date)
                        Button(action: {
                            birdController.birds.sort {($0.date < $1.date)}
                        }) {
                            Text("Sort by dates")
                                .fontWeight(.bold)
                                .padding(.horizontal, 20)
                        }
                    }
                    // Bird List
                    List(birdController.birds) { bird in
                        NavigationLink(destination: BirdDetailView(bird: bird)) {
                            HStack {
                                Text(bird.specie?.rawValue ?? "bird")
                                    .font(.headline)
                                Spacer()
                                Text(bird.date.formatted(date: .abbreviated, time: .shortened))
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                    Spacer()
                    
                    // Add bird Button
                    Button(action: {
                        showAddBirdView = true
                    }) {
                        Text("Add Bird")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .frame(maxWidth: 300)
                            .background(Color.yellow)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
                    }
                    .padding()
                }
            }
            .navigationTitle("Bird List")
        }
        .onAppear {
            showQuote = true
        }
        .sheet(isPresented: $showQuote) {
            QuoteView()
        }
        .sheet(isPresented: $showAddBirdView) {
            AddBirdView()
        }
    }
}

#Preview {
    ContentView()
        .environment(BirdController())
        .environment(StateController())
        .environment(LocationManager())
}


