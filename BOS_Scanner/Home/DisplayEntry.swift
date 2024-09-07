//  DisplayEntry.swift
//  BOS_Scanner
//
//  This SwiftUI view is responsible for displaying detailed information about an item from the database
//  and allows for editing its details like price, UPC, and updating its image. It integrates a photo picker for updating item images.
//
//  Created by EC.

import Foundation
import SwiftUI
import SwiftData
import PhotosUI

struct DisplayEntry: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @Binding var item: NewEntryModel?
    @State private var selectedPhoto: UIImage? = nil
    @State private var isPhotoPickerPresented: Bool = false
    
    var body: some View {
        Form {
            if let item = item {
                Section {
                    HStack {
                        ZStack {
                            if let selectedPhoto = selectedPhoto {
                                Image(uiImage: selectedPhoto)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                            } else if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
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
                    
                    TextField("UPC", text: Binding(
                        get: { item.upc },
                        set: { item.upc = $0 }
                    ))
                    .textFieldStyle(PlainTextFieldStyle())
                }
            } else {
                Text("No item to display")
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
        if let item = item {
            if let selectedPhoto = selectedPhoto {
                item.imageData = selectedPhoto.jpegData(compressionQuality: 0.8)
            }

            do {
                try context.save()
            } catch {
                print("Failed to save item: \(error.localizedDescription)")
            }
        }
    }
}

    
 
