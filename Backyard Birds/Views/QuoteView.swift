//
//  BirdDetailView.swift
//  Backyard Birds
//
//  Created by Kasper Jonassen on 09/12/2024.
//

import SwiftUI


struct QuoteView: View {
    @Environment(StateController.self) var stateController: StateController
    @AppStorage("QuoteID") private var quoteID: String?
    
    var body: some View {
        let quote = stateController.quote
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .orange, .indigo]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text(quote?.quote ?? "nikt")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 150)
                    .padding(.horizontal, 20)
                    .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                
                Text("- " + (quote?.author ?? "Flemming"))
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal, 20)
                
                VStack {
                    Spacer()
                    Text("#ID: " + (quoteID ?? "42069"))
                        .font(.system(size: 16, weight: .light, design: .monospaced))
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.bottom, 30)
                }
            }
        }
    }
}

#Preview {
    QuoteView().environment(StateController())
}
