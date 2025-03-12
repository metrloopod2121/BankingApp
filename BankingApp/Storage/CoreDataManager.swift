//
//  CoreDataManager.swift
//  BankingApp
//
//  Created by 𝕄𝕒𝕥𝕧𝕖𝕪 ℙ𝕠𝕕𝕘𝕠𝕣𝕟𝕚𝕪 on 12.03.2025.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func saveContext()
    func fetchAccounts() -> [Account]
    func fetchTransactions(for account: UUID) -> [Transaction]
    func addTransaction(_ amount: Double, _ type: String, _ date: Date, _ account: UUID)
    func deleteTransaction(by id: UUID)

}


class CoreDataManager: CoreDataManagerProtocol {
    
    static let shared = CoreDataManager()
    private var persistence = PersistenceController()
    
    
    func saveContext() {
        let context = persistence.container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    func fetchAccounts() -> [Account] {
        let request: NSFetchRequest<Account> = Account.fetchRequest()
        do {
            return try persistence.container.viewContext.fetch(request)
        } catch {
            print("Error fetching accounts: \(error)")
            return []
        }
    }
    
    func fetchTransactions(for accountID: UUID) -> [Transaction] {
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.predicate = NSPredicate(format: "accountID == %@", accountID as CVarArg)
        do {
            return try persistence.container.viewContext.fetch(request)
        } catch {
            print("Error fetching transactions: \(error)")
            return []
        }
    }
    
    func addTransaction(_ amount: Double, _ type: String, _ date: Date, _ account: UUID) {
        let context = persistence.container.viewContext
        let newTransaction = Transaction(context: context)
        newTransaction.amount = amount
        newTransaction.type = type
        newTransaction.date = Date()
        newTransaction.accountID = account
        saveContext()
        
    }
    
    func deleteTransaction(by id: UUID) {
        let context = persistence.container.viewContext
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            if let transaction = try context.fetch(request).first {
                context.delete(transaction)
                saveContext()
            }
        } catch {
            print("Error deleting transaction: \(error)")
        }
    }
    
    
    
}
