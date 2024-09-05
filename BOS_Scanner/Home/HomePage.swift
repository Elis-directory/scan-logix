//  HomePage.swift
//  BOS_Scanner
//
//  This file contains the SwiftUI view for the Scanner app's home page. It lists all items stored in the
//  database, providing functionality for navigating to detailed views of each item and deleting entries. This
//  view serves as the main interface for interacting with the app’s core features.
//
//  Created by EC

import SwiftUI
import SwiftData

class ViewModel: ObservableObject {
    @Published var title = " "
    @Published var currentPrice = " "
}

struct HomePage: View {
    @Environment(\.modelContext) private var context
    @Query private var items: [NewEntryModel]
    @State private var selectedItem: NewEntryModel?
    @State var isDismissed: Bool = false
    @StateObject var newItem = ViewModel()
    @State private var quantity: Int = 1
    @State private var addItemSheet = false

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                ZStack {
                    NavigationLink(destination: DisplayEntry(item: .constant(item))) {
                        
                    }
                    .opacity(0.0)
                    Text(item.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 10)
                }
            }
            .onDelete(perform: { indexSet in
                for index in indexSet {
                    deleteEntry(entry: items[index])
                }
            })
        }
        .padding(.top, 10)
    }

    func deleteEntry(entry: NewEntryModel) {
        context.delete(entry)
        do {
            try context.save()
            print("Item deleted successfully with image data.")
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }

}

    
    
 
#Preview {
    HomePage()
}
    
 

