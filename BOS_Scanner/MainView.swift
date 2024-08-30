//
//  ContentView.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 7/28/24.
//
//    @State private var showAddItemView = false


import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var context
    
    @Query private var items: [NewEntryModel]
    @State var currentView: DisplayState = .homeState
    @State private var isPresentingScanner = false
    @State private var scannedItem: NewEntryModel?
    @State private var showAddItemView = false
    @State private var scannedUPC: String? = nil
    @State var newListItem: String = ""
    @State private var addItemSheet = false
    
    var body: some View {
        VStack {
            Title()
            TabView {
                NavigationStack {
                    HomePage()
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                
                
                BarcodeScannerView(
                    items: items,
                    isPresenting: $isPresentingScanner,
                    matchedItem: $scannedItem,
                    showAddItemView: $showAddItemView,
                    scannedUPC: $scannedUPC // Pass the scanned UPC to BarcodeScannerView
                )
                .fullScreenCover(item: $scannedItem) { item in
                    NavigationStack {
                        DisplayEntry(item: .constant(item))
                    }
                }
                .alert(isPresented: $showAddItemView) {
                    
                    Alert(
                        title: Text("No Match Found"),
                        message: Text("The scanned barcode does not match any item in the database. Would you like to add a new item?"),
                        primaryButton: .default(Text("Add New Item")) {
                            showAddItemView = false
                            isPresentingScanner = false
                            addItemSheet = true
                        },
                        secondaryButton: .cancel {
                            showAddItemView = false
                            isPresentingScanner = false
                            
                        }
                    )
                }
                .sheet(isPresented: $addItemSheet) {
                    AddItemView(item: $newListItem, upc: scannedUPC ?? "")
                }
                .tabItem {
                    Label("Scan", systemImage: "barcode.viewfinder")
                }
                
                SearchPage()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                SettingsPage()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
            
            
            
        }
    }
}

           
            
                
//                switch currentView {
//                case .homeState:
//                    HomePage()
//                case .scanState:
//                    BarcodeScannerView(
//                        items: items,
//                        isPresenting: $isPresentingScanner,
//                        matchedItem: $scannedItem,
//                        showAddItemView: $showAddItemView,
//                        scannedUPC: $scannedUPC // Pass the scanned UPC to BarcodeScannerView
//                    )
//                    .fullScreenCover(item: $scannedItem) { item in
//                        NavigationStack {
//                            DisplayEntry(item: .constant(item))
//                        }
//                    }
//                    .alert(isPresented: $showAddItemView) {
//                        
//                        Alert(
//                            title: Text("No Match Found"),
//                            message: Text("The scanned barcode does not match any item in the database. Would you like to add a new item?"),
//                            primaryButton: .default(Text("Add New Item")) {
//                                showAddItemView = false // Dismiss the alert
//                                isPresentingScanner = false // Dismiss the scanner
//                                addItemSheet = true // Trigger the presentation of the AddItemView
//                            },
//                            secondaryButton: .cancel {
//                                showAddItemView = false
//                                isPresentingScanner = false // Dismiss the scanner
//                                currentView = .homeState
//                            }
//                        )
//                    }
//                    .sheet(isPresented: $addItemSheet) {
//                        AddItemView(item: $newListItem, upc: scannedUPC ?? "") // Provide a default value if scannedUPC is nil
//                        
//                    }
//                  
//
//                case .searchState:
//                    SearchPage()
//                case .settingsState:
//                    SettingsPage()
//                }
//            }
//            NavBarView(x: 32, y: 32, displayState: $currentView)
//        }
//    }
//}
//


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


