//
//  HomePage.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/16/24.
//

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
            print("Item saved successfully with image data.")
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }

    @ViewBuilder
    func singleItemUI(item: NewEntryModel) -> some View {
        VStack {
            Text(item.name)
            Text("\(item.price)")
            Text("\(item.id)")
        }
        .frame(width: 250, height: 250, alignment: .leading)
    }

}

    
    
    
 
#Preview {
    HomePage()
}
    
 

