//
//  title.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/16/24.
//

import SwiftUI
import SwiftData

struct Title: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @Query private var items: [TableModel]
    
    @State var createTableSheet: Bool = false
    @State var newListItem: String = ""
    
    var body: some View {
        HStack {
            Spacer()
            Text("ScanLogix")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.leading, 50)
              
                
               
            
            Button {
                createTableSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundStyle(Color.primary.opacity(0.6))
                    .frame(alignment: .trailing)
                  
                    .padding(.trailing, 20)
                
                
                
            }
            
            .sheet(isPresented: $createTableSheet, onDismiss: {
                createTableSheet = false
            })
            {  
               // createTable()
                AddItemView(item: $newListItem)
                
            }
           
        }
       
    }
    
    @ViewBuilder
    func createTable() -> some View {
        @State var itemTitle: String = ""
        @State var selectedCategory = "Cosmetics"
        var listCategories: [String] = ["Cosmetics", "Health & Beauty", "Houseware", "Jewlery", "Shoes", "Other"]
 
        VStack(alignment: .leading) {
                Text("Add New List")
                  .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                  .fontWeight(.semibold)
                  .padding(.top, 20)
                  .padding(.bottom, 20)
                
            
                Text("Title:")
                    .font(.headline)
                
                TextField(" ", text: $newListItem).font(.title2)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                
            
       
                Text("Categories:")
                    .font(.headline)
                    .padding(.top, 10)
            
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundStyle(Color(UIColor.secondarySystemBackground))
                    .frame(width: 120, height: 40)
                Picker("Picker", selection: $selectedCategory, content: {
                    ForEach(listCategories, id: \.self) {
                        Text($0)
                            .font(.headline)
                            //.tag($0)
                    }
                })
                .pickerStyle(MenuPickerStyle())
               
            }
            Text("you selected: \(selectedCategory)")
//                TextField(" ", text: $newListItemDescription).font(.title2)
//                    .padding()
//                    .background(Color(UIColor.secondarySystemBackground))
            
          
                Spacer()
            Button(action: {
                addItem()
                createTableSheet = false
                
            }, label: {
                ZStack{
                      
                    
                    RoundedRectangle(cornerRadius: 18.0)
                        .frame(width: 240, height: 60, alignment: .center)
                        .foregroundStyle(.blue)
                        
                    // .frame(minWidth: .infinity)
                        .padding()
                    Text("Create Item")
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            })
            }
        .padding()
      
      
    }
     func addItem() {
         let item = ItemModel(id: UUID(), name: "Test", currentPrice: 1.99, pricesHistory: [1.99], hyperlink: "test.com")
         let tableItem = TableModel(id: UUID(), name: newListItem, items:[item])
         context.insert(tableItem)
         //try? context.save()
     }

     func deleteItem(tableItem: TableModel) {
         context.delete(tableItem)
     }
}

#Preview {
    Title()
}
