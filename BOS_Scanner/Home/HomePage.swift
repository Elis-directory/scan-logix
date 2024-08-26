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

    @StateObject var newItem = ViewModel()
    @State private var quantity: Int = 1
    @State private var addItemSheet = false

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                ZStack {
                    NavigationLink(destination: DisplayEntry(item: .constant(item))) {
                        Text(item.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 10)
                    }
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
    }

    func deleteItem(at index: Int, from table: TableModel) {
        table.items.remove(at: index)
        try? context.save()
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

    @ViewBuilder
    func itemsUI(table: TableModel) -> some View {
        VStack(alignment: .leading) {
            List {
                ForEach(table.items, id: \.self) { item in
                    ZStack {
                        Text(item.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 10)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        deleteItem(at: index, from: table)
                    }
                })
                .sheet(isPresented: $addItemSheet, onDismiss: {
                    addItemSheet = false
                }) {
                    AddItemView(item: self.$newItem.title)
                }
            }
        }

        Button(action: {
            addItemSheet.toggle()
        }, label: {
            ZStack {
                Color(UIColor.secondarySystemBackground)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                
                Text("Add New Item")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        })
    }
}

    
    
    
 
#Preview {
    HomePage()
}
