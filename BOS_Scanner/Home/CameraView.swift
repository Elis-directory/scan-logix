//  CameraView.swift
//  BOS_Scanner
//
//  This file implements a camera view using the UIImagePickerController to allow users to capture images directly within the app. 
//  It is used primarily for adding images to new entries. The view requires camera access permissions to be set in the app's Info.plist.
//
//  Created by EC

import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

