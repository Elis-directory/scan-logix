//
//  MainAppView.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/10/24.
//

import SwiftUI

struct MainAppView: View {
    @State private var selectedType: String = "Regular"
        @State private var name: String = ""
        @State private var tags: [String] = ["facebook", "ads"]
        @State private var quantity: Int = 1
        
        var body: some View {
            VStack(spacing: 16) {
                Text("Create Card")
                    .font(.headline)
                    .padding(.top)
                
                HStack {
                    Button(action: {
                        selectedType = "Regular"
                    }) {
                        HStack {
                            Image(systemName: selectedType == "Regular" ? "largecircle.fill.circle" : "circle")
                            Text("Regular")
                        }
                    }
                    Spacer()
                    Button(action: {
                        selectedType = "Fulfillment"
                    }) {
                        HStack {
                            Image(systemName: selectedType == "Fulfillment" ? "largecircle.fill.circle" : "circle")
                            Text("Fulfillment")
                        }
                    }
                }
                .padding(.horizontal)
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Tags")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(tags, id: \.self) { tag in
                                Text(tag)
                                    .padding(8)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Stepper(value: $quantity, in: 1...10) {
                    Text("Quantity: \(quantity)")
                }
                .padding(.horizontal)
                
                HStack {
                    Button(action: {
                        // Handle cancel action
                    }) {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Button(action: {
                        // Handle continue action
                    }) {
                        Text("Continue")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(16)
            .padding()
        }
}

#Preview {
    MainAppView()
}
