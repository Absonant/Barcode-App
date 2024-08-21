//
//  Preferiti+CoreDataProperties.swift
//  BarcodeScannerApp
//
//  Created by Christian Valente on 19/08/24.
//
//

import Foundation
import CoreData


extension Preferiti {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Preferiti> {
        return NSFetchRequest<Preferiti>(entityName: "Preferiti")
    }

    @NSManaged public var dataAggiunta: Date?
    @NSManaged public var prodotto: Prodotto?
    @NSManaged public var utente: Utente?

}

extension Preferiti : Identifiable {

}
