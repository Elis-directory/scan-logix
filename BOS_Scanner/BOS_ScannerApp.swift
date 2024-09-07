//  BOS_ScannerApp.swift
//  BOS_Scanner
//
//  This file defines the main entry point of the Scanner application. It sets up the main window group
//  and attaches the MainView as the root view. This struct is marked with `@main`, indicating that it's
//  the starting point for the application.
//
//  Created by EC.

import SwiftUI
import SwiftData

@main
struct BOS_ScannerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: [NewEntryModel.self])
        }
    }
}
