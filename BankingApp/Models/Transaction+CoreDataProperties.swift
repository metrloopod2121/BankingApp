//
//  Transaction+CoreDataProperties.swift
//  BankingApp
//
//  Created by 𝕄𝕒𝕥𝕧𝕖𝕪 ℙ𝕠𝕕𝕘𝕠𝕣𝕟𝕚𝕪 on 12.03.2025.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var amount: Double
    @NSManaged public var currency: String?
    @NSManaged public var date: Date?
    @NSManaged public var type: String?
    @NSManaged public var accountID: UUID?

}

extension Transaction : Identifiable {

}

extension Transaction {
    var transactionType: TransactionType {
        get {
            return TransactionType(rawValue: self.type ?? "expense") ?? .expense
        }
        set {
            self.type = newValue.rawValue
        }
    }
}
