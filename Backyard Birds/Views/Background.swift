//
//  Background.swift
//  Backyard Birds
//
//  Created by Kasper Jonassen on 12/12/2024.
//

import Foundation
import SwiftUI

public var gradientBackground: some View {
    LinearGradient(
        gradient: Gradient(colors: [.white, .white, .orange, .green]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    .edgesIgnoringSafeArea(.all)
}
