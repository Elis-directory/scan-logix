//
//  Background.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/10/24.
//

import Foundation
import SwiftUI

struct BackgroundView: View {
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
    }
}
