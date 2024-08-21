import SwiftUI
import CoreData

struct AggiungiProdottoView: View {
    @ObservedObject var viewModel: CameraViewModel  // viewModel viene passato correttamente
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingPhotoCapture = false
    @State private var prodottoEsistente: Prodotto?

    var body: some View {
        VStack {
            if let prodotto = prodottoEsistente {
                Text("Prodotto già presente: \(prodotto.nome ?? "Nome non disponibile")")
                    .font(.headline)
                Button("Aggiorna informazioni") {
                    showingPhotoCapture = true
                }
            } else if viewModel.scannedCode != nil {
                Text("Prodotto non presente nel database")
                    .font(.headline)
                Button("Aggiungi Prodotto") {
                    showingPhotoCapture = true
                }
            } else {
                ScansionaProdottoView(viewModel: viewModel)  // viewModel viene passato correttamente
                    .onAppear {
                        viewModel.startScanning()
                    }
                    .onDisappear {
                        viewModel.stopScanning()
                    }
                    .onChange(of: viewModel.scannedCode) { oldCode, newCode in
                        if let code = newCode {
                            self.prodottoEsistente = checkIfProductExists(barcode: code)
                        }
                    }
            }
        }
        .sheet(isPresented: $showingPhotoCapture) {
            PhotoCaptureView(scannedCode: viewModel.scannedCode ?? "", existingProduct: prodottoEsistente, viewModel: viewModel)
        }
    }

    private func checkIfProductExists(barcode: String) -> Prodotto? {
        let fetchRequest: NSFetchRequest<Prodotto> = Prodotto.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "barcode == %@", barcode)
        do {
            let prodotti = try viewContext.fetch(fetchRequest)
            return prodotti.first
        } catch {
            print("Errore nel controllo del prodotto esistente: \(error)")
            return nil
        }
    }
}
