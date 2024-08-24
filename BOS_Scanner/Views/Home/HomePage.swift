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
    @Query private var items: [TableModel]
   
    
    @StateObject var newItem = ViewModel()
    
    @State private var quantity: Int = 1
    @State private var addItemSheet = false
  
   
    
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                ZStack {
                    
                    NavigationLink(item.name, destination: itemsUI(table: item))
                        .opacity(0)
                    
                    Text(item.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 10)
                }
                    
              
        }
        .onDelete(perform: { indexSet in
            for index in indexSet {
                deleteTable(tableItem: items[index])
            }
        })
    }
    .padding(.top, 10)
    }
    
    func deleteTable(tableItem: TableModel) {
        context.delete(tableItem)
    }
    
    func deleteItem(at index: Int, from table: TableModel) {
        // Remove the item from the table's items array
        table.items.remove(at: index)
        
        // Save the changes to the context
        try? context.save()
    }
    @ViewBuilder
    func singleItemUI(item: ItemModel) -> some View {
        VStack {
            Text(item.name)
            Text("\(item.currentPrice)")
            Text("\(item.id)")
            Text(item.hyperlink)
        }
        .frame(width: 250, height: 250, alignment: .leading)
    }
    
    @ViewBuilder
    func itemsUI(table: TableModel) -> some View {
      
      
         
        VStack(alignment: .leading) {
            
            
            
            List {
                
                ForEach(table.items, id: \.self) { item in
                    ZStack {
                        
                        NavigationLink(item.name, destination: singleItemUI(item: item))
                            .opacity(0)
                        
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
                })
                {
                  
                    AddItemView(item: self.$newItem.title)
         //           AddItemView(item: self.$newItem.title, price: " ", upc: " ")
                            
//                            TextField(" ", text: self.$newItem.title)

//                            
//                            TextField(" ", text: self.$newItem.currentPrice)

//                            
                         
                           // Text("Barocde")
                            
//                            Stepper(value: $quantity, in: 1...10) {
//                                Text("Quantity: \(quantity)")
//                            }
//                            .padding(.horizontal)
                            
//                                Button(action: {
//                                    let item = ItemModel(id: UUID(), name: newItem.title, currentPrice: self.newItem.currentPrice, pricesHistory: [1, 2], hyperlink: "test")
//                               
//                                                               withAnimation {
//                                                                   table.items.append(item)
//                                                               }
//                                                               context.insert(table)
//                                                               try? context.save()
//                               
//                               
//                                                               // Clear the text field after adding the item
//                                }) {
//                                    Text("Continue")
//                                        .foregroundColor(.white)
//                                        .padding()
//                                        .background(Color.blue)
//                                        .cornerRadius(8)
//                                }
//
                    
//
//                        }
//                        .padding()
//                        .background(Color(UIColor.systemGray6))
//                        .cornerRadius(16)
//                        .padding()
                    }
                    
                }
            }
            
            
           
            
            
            
            
//            ZStack {
//                TextField("Add New Item", text: self.$newItem.s)
//                    .font(.title)
//                    .padding(.top, 10)
//                    .padding(.leading, 10)
//                    .frame(maxWidth: .infinity, maxHeight: 100)
//                    .background(Color(UIColor.secondarySystemBackground))
//                
//                
//                HStack {
//                    Spacer()
//                    
//                    Button(action: {
//                        let item = ItemModel(id: UUID(), name: newItem.s, currentPrice: 1.99, pricesHistory: [1, 2], hyperlink: "test")
//                     
//                        withAnimation {
//                            table.items.append(item)
//                        }
//                        context.insert(table)
//                        try? context.save()
//                        
//                        
//                        // Clear the text field after adding the item
//                    }, label: {
//                        Image(systemName: "plus.circle")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .foregroundStyle(.secondary).opacity(0.4)
//                            .padding(.trailing, 30)
//                    })
//                }
//            }
        
        .padding(.bottom, 20) // Add padding to the VStack if needed
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
