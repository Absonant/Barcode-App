import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: CameraViewModel

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .black

        guard let captureSession = viewModel.captureSession else {
            print("captureSession è nil durante makeUIViewController")
            return viewController
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = viewController.view.bounds
        previewLayer.videoGravity = .resizeAspectFill

        viewController.view.layer.addSublayer(previewLayer)

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard let captureSession = viewModel.captureSession, captureSession.isRunning else {
            print("captureSession è nil o non in esecuzione durante updateUIViewController")
            return
        }

        if let previewLayer = uiViewController.view.layer.sublayers?.compactMap({ $0 as? AVCaptureVideoPreviewLayer }).first {
            previewLayer.frame = uiViewController.view.bounds
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: CameraView

        init(_ parent: CameraView) {
            self.parent = parent
        }
    }
}
