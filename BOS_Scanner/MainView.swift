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
    @Query private var items: [NewEntryModel]
    @State var currentView: DisplayState = .homeState
    @State private var isPresentingScanner = false
    @State private var scannedItem: NewEntryModel?
    @State private var showAddItemView = false

    var body: some View {
        VStack {
            Title()
            NavigationStack {
                switch currentView {
                case .homeState:
                    HomePage()
                case .scanState:
                    BarcodeScannerView(
                        items: items,
                        isPresenting: $isPresentingScanner,
                        matchedItem: $scannedItem,
                        showAddItemView: $showAddItemView
                    )
                    .fullScreenCover(item: $scannedItem, onDismiss: {
                        scannedItem = nil // Clear after dismissal if required
                    }) { item in
                        DisplayEntry(item: item)
                        
                    }

                    .alert(isPresented: $showAddItemView) {
                        Alert(
                            title: Text("No Match Found"),
                            message: Text("The scanned barcode does not match any item in the database. Would you like to add a new item?"),
                            primaryButton: .default(Text("Add New Item")) {
                                showAddItemView = true
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    .sheet(isPresented: $showAddItemView) {
                        AddItemView(item: .constant("")) // Use AddItemView to add a new item
                    }
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
            let container = try ModelContainer(for: NewEntryModel.self, configurations: config)
    
              return MainView()
                  .modelContainer(container)
          } catch {
              // Handle the error appropriately, possibly by returning an alternative view
              
              return Text("Failed to load model container")
          }
       
}


