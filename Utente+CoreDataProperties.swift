//
//  Utente+CoreDataProperties.swift
//  BarcodeScannerApp
//
//  Created by Christian Valente on 19/08/24.
//
//

import Foundation
import CoreData


extension Utente {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Utente> {
        return NSFetchRequest<Utente>(entityName: "Utente")
    }

    @NSManaged public var cognome: String?
    @NSManaged public var dataDiNascita: Date?
    @NSManaged public var email: String?
    @NSManaged public var fotoProfilo: Data?
    @NSManaged public var id: UUID?
    @NSManaged public var nome: String?
    @NSManaged public var password: String?
    @NSManaged public var preferiti: Preferiti?
    @NSManaged public var recensione: Recensione?

}

extension Utente : Identifiable {

}
