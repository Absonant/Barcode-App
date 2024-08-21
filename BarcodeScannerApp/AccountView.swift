//
//  AccountView.swift
//  BarcodeScannerApp
//
//  Created by Christian Valente on 17/08/24.
//

import Foundation
import SwiftUI

struct AccountView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var isAccountCreated: Bool = false

    var body: some View {
            VStack {
                Text("Profilo Utente")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(primaryColor)
                    .padding()

                // Dettagli del profilo
                Form {
                    Section(header: Text("Informazioni Personali")) {
                        Text("Nome Utente: John Doe")
                        Text("Email: johndoe@example.com")
                    }

                    Section {
                        Button(action: {
                            // Azione per il logout
                        }) {
                            Text("Logout")
                                .foregroundColor(.red)
                        }
                    }
                }

                Spacer()
            }
            .background(Color.white)
        }



    private func createAccount() {
        // Logica per creare un nuovo account
        // Potresti salvare i dati nel UserDefaults o in un database locale
        isAccountCreated = true
    }

    private func logout() {
        // Logica per il logout
        isAccountCreated = false
        username = ""
        email = ""
    }
}
