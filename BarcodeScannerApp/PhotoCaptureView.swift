import SwiftUI
import CoreData

struct PhotoCaptureView: View {
    let scannedCode: String?
    let existingProduct: Prodotto?
    @ObservedObject var viewModel: CameraViewModel // Aggiungi questo

    @Environment(\.presentationMode) var presentationMode
    @State private var capturedImages: [UIImage] = []
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            Text("Scatta le foto necessarie")
                .font(.headline)
                .padding()

            Button("Scatta Foto Barcode") {
                capturePhoto(type: "Barcode")
            }

            Button("Scatta Foto Fronte") {
                capturePhoto(type: "Fronte")
            }

            Button("Scatta Foto Retro") {
                capturePhoto(type: "Retro")
            }

            Button("Salva Prodotto") {
                saveProduct()
            }

            Button("Annulla") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    private func capturePhoto(type: String) {
        // Usa il viewModel per catturare la foto, se necessario
    }

    private func saveProduct() {
        let prodotto: Prodotto

        if let existing = existingProduct {
            prodotto = existing
        } else {
            prodotto = Prodotto(context: viewContext)
            prodotto.barcode = scannedCode
        }

        // Assegna le immagini scattate
        // prodotto.fotoFronte = capturedImages[0].pngData() // Esempio

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Errore nel salvataggio del prodotto: \(error)")
        }
    }
}
