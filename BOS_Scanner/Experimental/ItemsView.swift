//
//  ItemView.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 7/31/24.
//

//import SwiftUI
//import SwiftData
//
//struct ItemsView: View {
//    @Environment(\.modelContext) private var context
//    @Binding var items: [ItemModel]
//    
//    @State var newItem: String = ""
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            List {
//                ForEach(items) { item in
//                    Text(item.name)
//                }
//                .onDelete(perform: { indexSet in
//                    for index in indexSet {
//                        deleteItem(item: items[index])
//                    }
//                })
//            }
//           
//            TextField("Add New Item", text: $newItem)
//                .font(.title)
//                .padding(.top, 10)
//                .padding(.leading, 10)
//                .frame(maxWidth: .infinity)
//                .background(Color(UIColor.secondarySystemBackground))
//            
//            HStack {
//                Spacer()
//                
//                Button(action: {
//                    addItem(name: newItem)
//                    newItem = "" // Clear the text field after adding the item
//                }, label: {
//                    Image(systemName: "plus.circle")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        .foregroundStyle(.black).opacity(0.4)
//                        .padding(.trailing, 30)
//                })
//            }
//        }
//        .padding(.bottom, 20) // Add padding to the VStack if needed
//    }
//    
//    func addItem(name: String) {
//        let newItem = ItemModel(id: UUID(), name: name, currentPrice: 1.99, pricesHistory: [1, 2], hyperlink: "test")
//        withAnimation {
//            items.append(newItem)
//        }
//        context.insert(newItem)
//        try? context.save()
//    }
//    
//    func deleteItem(item: ItemModel) {
//        if let index = items.firstIndex(where: { $0.id == item.id }) {
//            items.remove(at: index)
//        }
//        context.delete(item)
//    }
//}

//#Preview {
//    ItemsView(name: "Item View Test", price: "Price")
//}
