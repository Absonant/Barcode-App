import AVFoundation
import SwiftUI

class CameraViewModel: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var scannedCode: String?
    var captureSession: AVCaptureSession?

    func startScanning() {
        if captureSession != nil && captureSession?.isRunning == true {
            print("Sessione già in esecuzione")
            return
        }

        print("Avvio scansione...")

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("Nessun dispositivo di cattura video trovato")
            return
        }

        let session = AVCaptureSession()

        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if session.canAddInput(videoInput) {
                session.addInput(videoInput)
            } else {
                print("Impossibile aggiungere l'input video alla sessione")
                return
            }
        } catch {
            print("Errore durante l'inizializzazione dell'input video: \(error)")
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean13, .ean8, .code128]
        } else {
            print("Impossibile aggiungere l'output dei metadati alla sessione")
            return
        }

        self.captureSession = session
        DispatchQueue.global(qos: .userInitiated).async {
            print("Inizio sessione...")
            session.startRunning()
            DispatchQueue.main.async {
                if session.isRunning {
                    print("Sessione della fotocamera è attiva")
                } else {
                    print("Sessione della fotocamera non è attiva")
                }
            }
        }
    }

    func stopScanning() {
        guard let session = captureSession, session.isRunning else {
            print("Sessione non attiva o già interrotta")
            return
        }

        print("Interruzione scansione...")
        DispatchQueue.global(qos: .userInitiated).async {
            session.stopRunning()
            DispatchQueue.main.async {
                self.captureSession = nil
                print("Sessione della fotocamera interrotta")
            }
        }
    }
}
