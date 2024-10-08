//  ContentView.swift
//  BOS_Scanner
//
//  This file defines the MainView struct, which serves as the primary view for the BOS_Scanner application.
//  It orchestrates various subviews including the home page, barcode scanner, search page, and settings.
//  This view manages the application's main navigation and handles the integration of the barcode scanning feature.
//
//  Created by EC.

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var context
    @Query private var items: [NewEntryModel]
    
    @State private var selectedTab = "Home"
    @State private var isPresentingScanner = false
    @State private var scannedItem: NewEntryModel?
    @State private var showAddItemView = false
    @State private var scannedUPC: String? = nil
    @State private var showAddItemAlert = false
    @State private var newListItem: String = ""

    var body: some View {
        VStack {
            Title()
            TabView(selection: $selectedTab) {
                NavigationStack {
                    HomePage() // Assuming HomePage is a defined View
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag("Home")
                
                BarcodeScannerView(
                    isPresenting: $isPresentingScanner,
                    matchedItem: $scannedItem,
                    showAddItemAlert: $showAddItemAlert,
                    showAddItemView: $showAddItemView,
                    scannedUPC: $scannedUPC
                )
                .fullScreenCover(item: $scannedItem) { item in
                    NavigationStack {
                        DisplayEntry(item: .constant(item))
                    }
                }
                .alert(isPresented: $showAddItemAlert) {
                    Alert(
                        title: Text("No Match Found"),
                        message: Text("The scanned barcode does not match any item in the database. Would you like to add a new item?"),
                        primaryButton: .default(Text("Add New Item")) {
                            showAddItemAlert = false
                            showAddItemView = true
                        },
                        secondaryButton: .cancel {
                            showAddItemAlert = false
                        }
                    )
                }
                .sheet(isPresented: $showAddItemView) {
                    AddItemView(item: $newListItem, upc: scannedUPC ?? "")
                }
                .tabItem {
                    Label("Scan", systemImage: "barcode.viewfinder")
                }
                .tag("Scan")
                
                SearchPage()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag("Search")
                
                PrivacySettingsView()
                    .tabItem {
                        Label("Privacy", systemImage: "lock.fill")
                       
                    }
                    .tag("Privacy")
                
//                SettingsPage()
//                    .tabItem {
                       // Label("Settings", systemImage: "gearshape")
//                     
//                       
//                    }
//                    .tag("Settings")
            }
            .onChange(of: selectedTab) { oldValue, newValue in
                // Only trigger when changing to or from the "Scan" tab
                if newValue == "Scan" {
                    isPresentingScanner = true
                } else if oldValue == "Scan" {
                    isPresentingScanner = false
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


