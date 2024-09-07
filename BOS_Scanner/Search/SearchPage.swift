//  SearchPage.swift
//  BOS_Scanner
//
//  This file defines the SearchPage view, which provides a searchable list of items
//  from the SwiftData context. Users can filter items by name, UPC, or category through
//  a search bar. When an item is selected, the app navigates to the detailed DisplayEntry view.
//
//  Created by EC.

import SwiftUI
import SwiftData


struct SearchPage: View {
    @Query private var items: [NewEntryModel]
    @State private var searchText: String = ""
    
    // Filtered results based on search text
    private var filteredItems: [NewEntryModel] {
        items.filter { item in
            searchText.isEmpty ||
            item.name.lowercased().contains(searchText.lowercased()) ||
            item.upc.lowercased().contains(searchText.lowercased()) ||
            item.category.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if filteredItems.isEmpty {
                    Text("No search results found")
                        .foregroundColor(.gray)
                } else {
                    ForEach(filteredItems, id: \.self) { item in
                        NavigationLink(destination: DisplayEntry(item: .constant(item))) {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text("UPC: \(item.upc)")
                                    .font(.subheadline)
                                Text("Category: \(item.category)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            .padding(.bottom, 50)
            
        }
    }
}


#Preview {
    SearchPage()
}
