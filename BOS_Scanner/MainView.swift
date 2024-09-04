//  ContentView.swift
//  BOS_Scanner
//
//  Description:
//  This file defines the MainView struct, which serves as the primary view for the BOS_Scanner application.
//  It orchestrates various subviews including the home page, barcode scanner, search page, and settings.
//  This view manages the application's main navigation and handles the integration of the barcode scanning feature.
//
//  Created by EC

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var context
    @Query private var items: [NewEntryModel]
    
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


