//
//  Background.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/10/24.
//

import Foundation
import SwiftUI
import SwiftData
import PhotosUI

struct DisplayEntry: View {
    @Environment(\.modelContext) private var context
    @State var item: NewEntryModel
    @State private var selectedPhoto: UIImage? = nil
    @State private var isPhotoPickerPresented: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section {
                HStack {
                    ZStack {
                        if let selectedPhoto = selectedPhoto {
                            Image(uiImage: selectedPhoto)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 80, height: 80)
                        }
                    }
                    .padding(.trailing)
                    
                    Button(action: {
                        isPhotoPickerPresented = true
                    }) {
                        Text(item.name)
                    }
                }
            }
            
            Section {
                TextField("Price", text: Binding(
                    get: { String(format: "%.2f", item.price) },
                    set: { item.price = Double($0) ?? 0.0 }
                ))
                .keyboardType(.decimalPad)
                .textFieldStyle(PlainTextFieldStyle())
                
                TextField("UPC", text: $item.upc)
                    .textFieldStyle(PlainTextFieldStyle())
                
                // Add any additional fields as needed
            }
        }
        .navigationBarItems(
            trailing: Button("Done") {
                saveItem()
                presentationMode.wrappedValue.dismiss()
            }
        )
        .sheet(isPresented: $isPhotoPickerPresented) {
            PhotoPicker(selectedImage: $selectedPhoto)
        }
    }

    func saveItem() {
//        if let selectedPhoto = selectedPhoto {
//            item.imageData = selectedPhoto.jpegData(compressionQuality: 0.8)
//        }

        do {
            try context.save() // Save changes to the context
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }
}



    
//    func saveChanges() {
//            // Find the original item in the context and update it
//            if let existingItem = context.fetch(NewEntryModel.self).first(where: { $0.id == item.id }) {
//                existingItem.name = item.name
//                existingItem.price = item.price
//                existingItem.upc = item.upc
//                // Update other properties as needed
//            }
//
//            // Save the context
//            try? context.save()
//        }
    
 
