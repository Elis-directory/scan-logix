//
//  BarcodeScannerView.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/24/24.
//

import SwiftUI
import AVFoundation
import SwiftData

struct BarcodeScannerView: UIViewControllerRepresentable {
    var items: [NewEntryModel]
    
    @Binding var isPresenting: Bool
    @Binding var matchedItem: NewEntryModel?
    @Binding var showAddItemView: Bool
    @Binding var scannedUPC: String? // Add this binding to pass the scanned UPC

    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: BarcodeScannerView

        init(parent: BarcodeScannerView) {
            self.parent = parent
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                      let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                // Stop the capture session to avoid multiple detections
                parent.stopCaptureSession()
                
                // Handle the scanned code
                parent.handleScannedCode(stringValue)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()

        DispatchQueue.global(qos: .userInitiated).async {
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
            let videoInput: AVCaptureDeviceInput

            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                return
            }

            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            } else {
                return
            }

            let metadataOutput = AVCaptureMetadataOutput()

            if captureSession.canAddOutput(metadataOutput) {
                captureSession.addOutput(metadataOutput)

                metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.ean8, .ean13]
            } else {
                return
            }

            DispatchQueue.main.async {
                let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer.frame = viewController.view.layer.bounds
                previewLayer.videoGravity = .resizeAspectFill
                viewController.view.layer.addSublayer(previewLayer)
            }

            captureSession.startRunning()
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    // Stop the capture session to avoid repeated detections
    func stopCaptureSession() {
        DispatchQueue.main.async {
            let captureSession = AVCaptureSession()
            captureSession.stopRunning()
        }
    }

    func handleScannedCode(_ code: String) {
        DispatchQueue.main.async {
            if let matchedItem = items.first(where: { $0.upc == code }) {
                print("Item found: \(matchedItem.name)") // Debugging print statement
                self.matchedItem = matchedItem
                isPresenting = false
            } else {
                print("No match found. Triggering AddItemView.") // Debugging print statement
                self.scannedUPC = code // Store the scanned UPC code
                showAddItemView = true
                isPresenting = false
            }
        }
    }
}


