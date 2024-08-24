//
//  MainAppView.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/10/24.
//

import SwiftUI

struct MainAppView: View {
    @State private var selectedType: String = "Regular"
        @State private var name: String = ""
        @State private var tags: [String] = ["facebook", "ads"]
        @State private var quantity: Int = 1
        
        var body: some View {
            VStack(spacing: 16) {
                Text("Create Card")
                    .font(.headline)
                    .padding(.top)
                
                HStack {
                    Button(action: {
                        selectedType = "Regular"
                    }) {
                        HStack {
                            Image(systemName: selectedType == "Regular" ? "largecircle.fill.circle" : "circle")
                            Text("Regular")
                        }
                    }
                    Spacer()
                    Button(action: {
                        selectedType = "Fulfillment"
                    }) {
                        HStack {
                            Image(systemName: selectedType == "Fulfillment" ? "largecircle.fill.circle" : "circle")
                            Text("Fulfillment")
                        }
                    }
                }
                .padding(.horizontal)
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Tags")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(tags, id: \.self) { tag in
                                Text(tag)
                                    .padding(8)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Stepper(value: $quantity, in: 1...10) {
                    Text("Quantity: \(quantity)")
                }
                .padding(.horizontal)
                
                HStack {
                    Button(action: {
                        // Handle cancel action
                    }) {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Button(action: {
                        // Handle continue action
                    }) {
                        Text("Continue")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(16)
            .padding()
        }
}

#Preview {
    MainAppView()
}
//struct MainView: View {
//   // @Environment(\.modelContext) private var context
//    //@Query private var items: [ItemModel]
//
//    var body: some View {
//        VStack {
////            List {
////                ForEach(items) { item in
////                    Text(item.name)
////                    }
////                    .onDelete(perform: { indexSet in
////                        for index in indexSet {
////                                deleteItem(item: items[index])
////                        }
////                    })
////                }
////                    Button(action: addItem) {
//                      Text("Add")
//         //   }
//
//
//                }
//                .padding()
//            }
////    Button(action: addItem) {
////        Text("Add")
////    }
////                        Button(action: {
////                            //createTableSheet.toggle()
////
////                                   }) {
////                                       Image(systemName: "plus.circle")
////                                           .resizable()
////                                           .frame(width: 60, height: 60)
////                                           .foregroundStyle(.yellow)
////                                           .padding()
////                                   }
////                                   .padding()
//
//
//  //              }
//
//
//
//
////    @ViewBuilder
////    func createTable() -> some View {
////        @State var userInput: String = ""
////        TextField("Title",
////                  text: $userInput)
////    }
//
////     func addItem() {
////         let item = ItemModel(id: UUID(
////         ), name: "Test1", currentPrice: 1.99, pricesHistory: [1.0], hyperlink: "test")
////         context.insert(item)
////         try? context.save()
////     }
////
////     func deleteItem(item: ItemModel) {
////         context.delete(item)
////     }
////
//}
//
//#Preview {
////    do {
////          let config = ModelConfiguration()
////          let container = try ModelContainer(for: ItemModel.self, configurations: config)
////
////          return MainView()
////              .modelContainer(container)
////      } catch {
////          // Handle the error appropriately, possibly by returning an alternative view
////          return Text("Failed to load model container")
////      }
//    MainView()
//}
