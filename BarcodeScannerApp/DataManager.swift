import CoreData
import SwiftUI

class DataManager {

    static let shared = DataManager()

    private var viewContext: NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }

    // Salva un nuovo prodotto
    func salvaProdotto(barcode: String, nome: String, marchio: String, categoria: String, descrizione: String, stabilimento: String, ingredienti: String, informazioniNutrizionali: String, foto: Data, prezzo: Double) {
        let nuovoProdotto = Prodotto(context: viewContext) // Assicurati che questa classe sia generata correttamente
        nuovoProdotto.id = UUID() // UUID dovrebbe essere un attributo nel modello Core Data
        nuovoProdotto.barcode = barcode
        nuovoProdotto.nome = nome
        nuovoProdotto.marchio = marchio
        nuovoProdotto.categoria = categoria
        nuovoProdotto.descrizione = descrizione
        nuovoProdotto.stabilimento = stabilimento
        nuovoProdotto.ingredienti = ingredienti
        nuovoProdotto.informazioniNutrizionali = informazioniNutrizionali
        nuovoProdotto.fotoFronte = foto
        nuovoProdotto.prezzo = prezzo

        do {
            try viewContext.save()
            print("Prodotto salvato correttamente!")
        } catch {
            print("Errore nel salvataggio del prodotto: \(error)")
        }
    }

    // Recupera tutti i prodotti
    func recuperaProdotti() -> [Prodotto] {
        let fetchRequest: NSFetchRequest<Prodotto> = Prodotto.fetchRequest()
        
        do {
            let prodotti = try viewContext.fetch(fetchRequest)
            return prodotti
        } catch {
            print("Errore nel recupero dei prodotti: \(error)")
            return []
        }
    }
}
