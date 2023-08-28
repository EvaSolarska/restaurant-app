//
//  DatabaseService.swift
//  restaurant
//
//  Created by Ewa Solarska on 28/08/2023.
//

import SwiftUI
import CoreData
import UIKit

class DatabaseService {
    static let shared = DatabaseService()
    private init() {}
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("\(nsError), \(nsError.userInfo)")
        }
    }
    
    func addCategory(context: NSManagedObjectContext) {
        let categories = [
            "Pizza", "Beverages", "Hamburgers","Hot-dogs"
        ]
        categories.forEach { category in
            let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", category)
            
            do {
                let existingCategories = try context.fetch(fetchRequest)
                if existingCategories.isEmpty {
                    let newCategory = Category(context: context)
                    newCategory.name = category
                    try context.save()
                }
            } catch {
                let nsError = error as NSError
                fatalError("\(nsError), \(nsError.userInfo)")
            }
        }
    }
}
