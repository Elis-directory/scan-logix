//
//  TablesView.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 7/28/24.
//

import SwiftUI
import SwiftData

struct AddItemView: View {
    @Environment(\.modelContext) private var context
//    @Query private var items: [TableModel]
    @Query private var items: [ItemModel]
    
    
    @Binding var item: String
//    @Binding var price: String
//    @Binding var upc: String
    
    @State private var price: String = " "
    @State private var upc: String = " "
   
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 80, height: 80)
                            
                            Text("")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                        
                        Button(action: {
                            // Action to add photo
                        }) {
                            Text("Add Photo")
                        }
                    }
                }
                
                Section {
                    TextField("Item", text: $item)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    TextField("Price", text: $price)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    TextField("UPC", text: $upc)
                        .textFieldStyle(PlainTextFieldStyle())
                }
            }
            .navigationBarTitle("New Entry", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    // Action to cancel
                },
                trailing: Button("Done") {
                    // Action to save contact
                    addItem()
                }
            )
        }
    }
    
    func addItem() {
        let item = ItemModel(id: UUID(), name: "Test", currentPrice: 1.99, pricesHistory: [1.99], hyperlink: "test.com")
      
        context.insert(item)
        //try? context.save()
    }
}


#Preview {
    @State var item: String = ""
    @State var price: String = ""
    @State var upc: String = ""
  
    

    return AddItemView(item: $item)
}
