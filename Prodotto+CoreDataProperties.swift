//
//  Prodotto+CoreDataProperties.swift
//  BarcodeScannerApp
//
//  Created by Christian Valente on 19/08/24.
//
//

import Foundation
import CoreData


extension Prodotto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Prodotto> {
        return NSFetchRequest<Prodotto>(entityName: "Prodotto")
    }

    @NSManaged public var barcode: String?
    @NSManaged public var categoria: String?
    @NSManaged public var descrizione: String?
    @NSManaged public var fotoFronte: Data?
    @NSManaged public var fotoInfoNutrizionali: Data?
    @NSManaged public var fotoIngredienti: Data?
    @NSManaged public var fotoRetro: Data?
    @NSManaged public var fotoStabilimento: Data?
    @NSManaged public var id: UUID?
    @NSManaged public var informazioniNutrizionali: String?
    @NSManaged public var ingredienti: String?
    @NSManaged public var marchio: String?
    @NSManaged public var nome: String?
    @NSManaged public var prezzo: Double
    @NSManaged public var stabilimento: String?
    @NSManaged public var preferiti: Preferiti?
    @NSManaged public var recensione: Recensione?

}

extension Prodotto : Identifiable {

}
