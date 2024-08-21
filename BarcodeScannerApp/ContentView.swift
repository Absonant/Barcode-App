import SwiftUI

// Definizione del colore principale utilizzando l'estensione
let primaryColor = Color(hex: "00917a")

// Estensione per creare un colore da un codice esadecimale
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            let r = Double((hexNumber & 0xff0000) >> 16) / 255
            let g = Double((hexNumber & 0x00ff00) >> 8) / 255
            let b = Double(hexNumber & 0x0000ff) / 255
            self.init(red: r, green: g, blue: b)
        } else {
            self.init(red: 0, green: 0, blue: 0)
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = CameraViewModel()
    @State private var showAccountScreen = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Barra di navigazione superiore con il titolo
                HStack {
                    Text("CERCA PRODOTTO")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading)
                    Spacer()
                }
                .background(primaryColor)

                // Corpo della vista con il contenuto
                Spacer()

                // Tab Bar inferiore
                TabView {
                    CercaProdottoView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Cerca")
                        }

                    AggiungiProdottoView(viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "plus.circle")
                            Text("Scansiona")
                        }

                    Button(action: {
                        showAccountScreen.toggle() // Mostra la schermata dell'account
                    }) {
                        Text("Account")
                    }
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("Account")
                    }
                    .sheet(isPresented: $showAccountScreen) {
                        AccountView() // Mostra la vista dell'account come una sheet
                    }
                }
                .accentColor(primaryColor)
                .background(Color.white)
                .edgesIgnoringSafeArea(.bottom)
            }
            .background(Color.white.edgesIgnoringSafeArea(.all)) // Background principale dell'app
            .navigationBarHidden(true) // Nasconde la barra di navigazione standard
        }
    }
}
