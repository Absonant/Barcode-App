import Foundation
import SwiftUI
import CoreData

struct ProdottoCardView: View {
    let prodotto: Prodotto

    var body: some View {
        VStack {
            // Mostra la foto fronte del prodotto, se disponibile
            if let imageData = prodotto.fotoFronte, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                    .foregroundColor(.gray)
            }

            Text(prodotto.barcode ?? "Codice non disponibile")
                .font(.caption)
                .lineLimit(1)
            
            // Aggiungi qui le altre foto se necessario, ad esempio:
            if let infoNutrizionaliData = prodotto.fotoInfoNutrizionali, let infoNutrizionaliImage = UIImage(data: infoNutrizionaliData) {
                Image(uiImage: infoNutrizionaliImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
            }

            if let ingredientiData = prodotto.fotoIngredienti, let ingredientiImage = UIImage(data: ingredientiData) {
                Image(uiImage: ingredientiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
            }
            
            if let retroData = prodotto.fotoRetro, let retroImage = UIImage(data: retroData) {
                Image(uiImage: retroImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
            }
            
            if let stabilimentoData = prodotto.fotoStabilimento, let stabilimentoImage = UIImage(data: stabilimentoData) {
                Image(uiImage: stabilimentoImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
