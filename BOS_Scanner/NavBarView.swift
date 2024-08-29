//
//  NavBarView.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/15/24.
//

import SwiftUI
import Foundation

struct NavBarView: View {
    @State var x: CGFloat
    @State var y: CGFloat
    @Binding var displayState: DisplayState

    var body: some View {
        Spacer()
        HStack(spacing: (x + y) * 0.75) {
            // Home button
            Button(action: {
                print("Home Button Clicked")
                displayState = .homeState
                
            }, label: {
                VStack {
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: x, height: y)
                        .foregroundStyle(Color.primary.opacity(0.6))
                    .aspectRatio(contentMode: .fit)
                    Text("Home")
                        .font(.caption)
                        .foregroundStyle(Color.primary.opacity(0.6))
                }
            })
            
            // Scan button
            Button(action: {
                print("Scan Button Clicked")
                displayState = .scanState
                
            }, label: {
                VStack {
                Image(systemName: "barcode.viewfinder")
                    .resizable()
                    .frame(width: x, height: y)
                    .foregroundStyle(Color.primary.opacity(0.6))
                    .aspectRatio(contentMode: .fit)
                Text("Scan")
                    .font(.caption)
                    .foregroundStyle(Color.primary.opacity(0.6))
            }
            })
            
            // Search Button
            Button(action: {
                print("Search Button Clicked")
                displayState = .searchState
                
            }, label: {
                VStack {
                Image(systemName:"magnifyingglass")
                    .resizable()
                    .frame(width: x, height: y)
                    .foregroundStyle(Color.primary.opacity(0.6))
                    .aspectRatio(contentMode: .fit)
                    Text("Search")
                        .font(.caption)
                        .foregroundStyle(Color.primary.opacity(0.6))
                }
               
            })
            
            // Settings Button
            Button(action: {
                print("Settings Button Clicked")
                displayState = .settingsState
                
            }, label: {
                VStack {
                Image(systemName: "gearshape")
                    .resizable()
                    .frame(width: x, height: y)
                    .foregroundStyle(Color.primary.opacity(0.6))
                    .aspectRatio(contentMode: .fit)
                Text("Settings")
                    .font(.caption)
                    .foregroundStyle(Color.primary.opacity(0.6))
            }
            })
            
           
        }
        .padding(.top, 10)
    }
}
#Preview {
    @State var displayState: DisplayState = .homeState
    return NavBarView(x: 30, y: 30, displayState: $displayState)
}
