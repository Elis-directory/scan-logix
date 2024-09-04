//
//  BarcodeScannerView.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/24/24.
//

import SwiftUI
import AVFoundation

struct BarcodeScannerView: UIViewControllerRepresentable {
    var items: [NewEntryModel]
    
    @Binding var isPresenting: Bool
    @Binding var matchedItem: NewEntryModel?
    @Binding var showAddItemView: Bool
    @Binding var scannedUPC: String?

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        context.coordinator.setupCaptureSession(viewController.view)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // This function can be used to update things like session parameters or react to state changes
    }

    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: BarcodeScannerView
        var captureSession: AVCaptureSession?
        var previewLayer: AVCaptureVideoPreviewLayer?

        init(parent: BarcodeScannerView) {
            self.parent = parent
        }

        func setupCaptureSession(_ view: UIView) {
            DispatchQueue.global(qos: .userInitiated).async {
                let session = AVCaptureSession()
                guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
                      let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice),
                      session.canAddInput(videoInput) else {
                    print("Failed to set up device input")
                    return
                }

                session.addInput(videoInput)
                let metadataOutput = AVCaptureMetadataOutput()
                if session.canAddOutput(metadataOutput) {
                    session.addOutput(metadataOutput)
                    metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                    metadataOutput.metadataObjectTypes = [.ean8, .ean13] 
                } else {
                    print("Failed to set up metadata output")
                    return
                }

                DispatchQueue.main.async {
                    self.previewLayer = AVCaptureVideoPreviewLayer(session: session)
                    self.previewLayer?.frame = view.bounds
                    self.previewLayer?.videoGravity = .resizeAspectFill
                    view.layer.addSublayer(self.previewLayer!)
                }

                self.captureSession = session
                session.startRunning() // Start the session running on a background thread
            }
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            guard let metadataObject = metadataObjects.first,
                  let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                  let stringValue = readableObject.stringValue else { return }

            DispatchQueue.main.async {
                self.handleScannedCode(stringValue)
                self.parent.isPresenting = true
            }
        }

        func handleScannedCode(_ code: String) {
            DispatchQueue.global(qos: .userInitiated).async {
               // self.captureSession?.stopRunning()
                DispatchQueue.main.async {
                    if let matchedItem = self.parent.items.first(where: { $0.upc == code }) {
                        self.parent.matchedItem = matchedItem
                        self.parent.isPresenting = false
                    } else {
                        self.parent.scannedUPC = code
                        self.parent.showAddItemView = true
                        self.parent.isPresenting = false
                    }
                }
               
            }
           
        }
    }
}
