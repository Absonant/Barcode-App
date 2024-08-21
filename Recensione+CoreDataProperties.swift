//
//  Recensione+CoreDataProperties.swift
//  BarcodeScannerApp
//
//  Created by Christian Valente on 19/08/24.
//
//

import Foundation
import CoreData


extension Recensione {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recensione> {
        return NSFetchRequest<Recensione>(entityName: "Recensione")
    }

    @NSManaged public var commento: String?
    @NSManaged public var data: Date?
    @NSManaged public var rating: Int16
    @NSManaged public var prodotto: Prodotto?
    @NSManaged public var utente: Utente?

}

extension Recensione : Identifiable {

}
