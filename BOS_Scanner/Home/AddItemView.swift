//
//  TablesView.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 7/28/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddItemView: View {
    @Environment(\.modelContext) private var context
    @Binding var item: String
    @State private var price: String = ""
    @State var upc: String
    @State private var selectedPhoto: UIImage? = nil
    @State private var isPhotoPickerPresented: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
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
                            Text("Add Photo")
                        }
                    }
                }
                
                Section {
                    TextField("Item", text: $item)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    TextField("UPC", text: $upc)
                        .textFieldStyle(PlainTextFieldStyle())
                }
            }
            .navigationBarTitle("New Entry", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    resetForm()
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Done") {
                    if validateInput() {
                        saveItem()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
            .sheet(isPresented: $isPhotoPickerPresented) {
                PhotoPicker(selectedImage: $selectedPhoto)
            }
        }
    }
    
    func resetForm() {
        item = ""
        price = ""
        upc = ""
        selectedPhoto = nil
    }
    
    func validateInput() -> Bool {
        guard !item.isEmpty, let _ = Double(price) else {
            return false
        }
        return true
    }
    
    func saveItem() {
        guard !item.isEmpty, let priceValue = Double(price), !upc.isEmpty else {
            return
        }

        let imageData = selectedPhoto?.jpegData(compressionQuality: 0.8) // Convert image to Data

        let newItem = NewEntryModel(
            id: UUID(),
            name: item,
            price: CGFloat(priceValue),
            upc: upc,
            category: "Default Category",
            imageData: imageData // Save image data
        )
        
        context.insert(newItem)
        
        do {
            try context.save()
            print("Item saved successfully with image data.")
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }
}






struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else { return }
            
            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    self.parent.selectedImage = image as? UIImage
                }
            }
        }
    }
}



#Preview {
    @State var item: String = ""
    @State var price: String = ""
    @State var upc: String = ""
  
    

    return AddItemView(item: $item, upc: upc)
}



//                Picker("Picker", selection: $selectedCategory, content: {
//                    ForEach(listCategories, id: \.self) {
//                        Text($0)
//                            .font(.headline)
//                            //.tag($0)
//                    }
//                })
//                .pickerStyle(MenuPickerStyle())
//
          
//    func addItem() {
//        let item = ItemModel(id: UUID(), name: "Test", currentPrice: 1.99, pricesHistory: [1.99], hyperlink: "test.com")
//        let tableItem = TableModel(id: UUID(), name: newListItem, items:[item])
//        context.insert(tableItem)
//        //try? context.save()
//    }
//
//    func deleteItem(tableItem: TableModel) {
//        context.delete(tableItem)
//    }
