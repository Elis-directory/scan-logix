//
//
//  BOS_ScannerApp.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 7/28/24.
//

import SwiftUI
import SwiftData

@main
struct BOS_ScannerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: [TableModel.self, ItemModel.self])
        }
    }
}
