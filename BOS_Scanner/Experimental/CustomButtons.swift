//
//  CustomButtons.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/10/24.
//

import SwiftUI

struct CustomButtons: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(Color.yellow, lineWidth: 12)
                .fill(.red)
                .frame(width: 300, height: 50)
            
            Text("Create New List")
                .font(.title)
                .foregroundStyle(.yellow)
                .fontWeight(.medium)
                     
        }
    }
}

#Preview {
    CustomButtons()
}
// 
