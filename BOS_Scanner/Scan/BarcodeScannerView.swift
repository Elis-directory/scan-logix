//  BarcodeScannerView.swift
//  BOS_Scanner
//
//  This file defines the BarcodeScannerView, a SwiftUI view using UIViewControllerRepresentable
//  to incorporate an AVCaptureSession for scanning barcodes. The scanned barcodes are matched
//  against items in the SwiftData context. If a match is found, the corresponding item is displayed;
//  otherwise, an alert prompts the user to add a new item.
//
//  Created by EC.

import SwiftUI
import AVFoundation
import SwiftData

struct BarcodeScannerView: UIViewControllerRepresentable {
    @Environment(\.modelContext) private var context
    @Query private var items: [NewEntryModel]
    @Binding var isPresenting: Bool
    @Binding var matchedItem: NewEntryModel?
    @Binding var showAddItemAlert: Bool  // Control showing the alert when no match is found
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
        context.coordinator.updateSessionState(isPresenting: isPresenting)
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
                    metadataOutput.metadataObjectTypes = [.ean8, .ean13] // Barcode types
                } else {
                    print("Failed to set up metadata output")
                    return
                }

                self.captureSession = session
                self.startCaptureSession(session, view: view)
            }
        }

        private func startCaptureSession(_ session: AVCaptureSession, view: UIView) {
            DispatchQueue.main.async {
                self.previewLayer = AVCaptureVideoPreviewLayer(session: session)
                self.previewLayer?.frame = view.bounds
                self.previewLayer?.videoGravity = .resizeAspectFill
                view.layer.addSublayer(self.previewLayer!)
            }
            session.startRunning() // Start session on background thread
        }

        func updateSessionState(isPresenting: Bool) {
            if isPresenting {
                startSession()
            } else {
                stopSession()
            }
        }

        private func startSession() {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession?.startRunning()
            }
        }

        private func stopSession() {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession?.stopRunning()
            }
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            guard let metadataObject = metadataObjects.first,
                  let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                  let stringValue = readableObject.stringValue else { return }

            DispatchQueue.main.async {
                self.parent.scannedUPC = stringValue
                
                // Re-fetch the items to ensure the latest state
                if let matchedItem = self.parent.items.first(where: { $0.upc == stringValue }) {
                    self.parent.matchedItem = matchedItem
                    self.parent.isPresenting = true
                } else {
                    self.parent.showAddItemAlert = true
                }
            }
        }
    }

}

