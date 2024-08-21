//
//  CercaProdottoView.swift
//  BarcodeScannerApp
//
//  Created by Christian Valente on 17/08/24.
//

import Foundation
import SwiftUI
import CoreData

struct CercaProdottoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(primaryColor)
                TextField("Cerca prodotto", text: .constant(""))
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top)

            // Area dei risultati di ricerca
            VStack(alignment: .leading, spacing: 10) {
                Text("Risultati della ricerca")
                    .font(.headline)
                    .foregroundColor(primaryColor)
                
                // Esempio di un risultato di prodotto
                HStack {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                    Text("Nome del prodotto")
                        .font(.body)
                        .foregroundColor(.black)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .shadow(radius: 5)
            .padding(.horizontal)

            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }

    @Environment(\.managedObjectContext) private var viewContext

    @State private var searchText: String = ""
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Prodotto.barcode, ascending: true)],
        animation: .default)
    private var prodotti: FetchedResults<Prodotto>

    var filteredProdotti: [Prodotto] {
        if searchText.isEmpty {
            return Array(prodotti)
        } else {
            return prodotti.filter { $0.barcode?.lowercased().contains(searchText.lowercased()) ?? false }
        }
    }

}

