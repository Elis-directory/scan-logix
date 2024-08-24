//
//  ContentView.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 7/28/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var context
    @Query private var items: [TableModel]
    @State var currentView: DisplayState = .homeState
  
  
    
    var body: some View {
        VStack {
            Title()
            NavigationStack {
                switch currentView {
                    case .homeState:
                        HomePage()
                    case .scanState:
                        ScanPage()
                    case .searchState:
                        SearchPage()
                    case .settingsState:
                        SettingsPage()
                }
            }
            NavBarView(x: 32, y: 32, displayState: $currentView)
        }
    }
}

#Preview {
        do {
              let config = ModelConfiguration()
            let container = try ModelContainer(for: TableModel.self, ItemModel.self, configurations: config)
    
              return MainView()
                  .modelContainer(container)
          } catch {
              // Handle the error appropriately, possibly by returning an alternative view
              
              return Text("Failed to load model container")
          }
       
}


