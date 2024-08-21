import SwiftUI
import CoreData

struct ScansionaProdottoView: View {
    @ObservedObject var viewModel: CameraViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @State private var prodottoTrovato: Prodotto?

    var body: some View {
        ZStack {
            CameraView(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
                .mask(
                    VStack {
                        Color.black.opacity(0.6)
                        Rectangle().frame(height: 300) // Regola l'altezza della striscia visibile
                        Color.black.opacity(0.6)
                    }
                )

            // Aggiungi una sovrapposizione per il riquadro del barcode
            VStack {
                Spacer()
                Rectangle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.green)
                    .frame(width: 300, height: 150) // Dimensione del riquadro del barcode
                Spacer()
            }

            // Aggiungi il resto della UI sopra la maschera
            VStack {
                Text("Allinea il codice a barre con il riquadro")
                    .foregroundColor(.white)
                    .padding(.top, 20)
                Spacer()
            }

            if let prodotto = prodottoTrovato {
                VStack {
                    Text("Prodotto trovato: \(prodotto.nome ?? "Nome non disponibile")")
                        .font(.headline)
                        .padding()
                }
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
            }
        }
        .onAppear {
            viewModel.startScanning()
        }
        .onDisappear {
            viewModel.stopScanning()
        }
        .onChange(of: viewModel.scannedCode) { newCode in
            if let code = newCode {
                self.prodottoTrovato = checkIfProductExists(barcode: code)
            }
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
