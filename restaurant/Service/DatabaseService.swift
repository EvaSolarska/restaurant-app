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
    
    func addProducts(context: NSManagedObjectContext, categories: [Category]) {
        let categoriesDict = Dictionary(uniqueKeysWithValues: categories.map { ($0.name!, $0) })
        
        let products = [
            ProductModel(name: "Margherita", desc: "Classic pizza with tomato sauce and mozzarella", price: 56.23, image: (UIImage(named: "image")?.pngData())!, category: categoriesDict["Pizza"]!),
            ProductModel(name: "Apple juice", desc: "Refreshing apple juice", price: 12.23, image: (UIImage(named: "image")?.pngData())!, category: categoriesDict["Beverages"]!),
            ProductModel(name: "Hamburger", desc: "Delicious hamburger with beef and cheese", price: 29.99, image: (UIImage(named: "image")?.pngData())!, category: categoriesDict["Hamburgers"]!),
            ProductModel(name: "Hot-Dog", desc: "Hot-dog with sausage, ketchup, and mustard", price: 19.99, image: (UIImage(named: "image")?.pngData())!, category: categoriesDict["Hot-dogs"]!),
            ProductModel(name: "Mineral Water", desc: "Non-carbonated mineral water", price: 5.99, image: (UIImage(named: "image")?.pngData())!, category: categoriesDict["Beverages"]!),
            ProductModel(name: "Lemonade", desc: "Refreshing lemon-flavored drink with lemon slices", price: 15.99, image: (UIImage(named: "image")?.pngData())!, category: categoriesDict["Beverages"]!),
        ]
        
        
        for product in products {
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", product.name)
            
            do {
                let existingProducts = try context.fetch(fetchRequest)
                if existingProducts.isEmpty {
                    let newProduct = Product(context: context)
                    newProduct.price = product.price
                    newProduct.name = product.name
                    newProduct.desc = product.desc
                    newProduct.image = product.image
                    
                    if let category = categories.first(where: { $0.name == product.category.name }) {
                        newProduct.toCategory = category
                    }
                    
                    try context.save()
                }
            } catch {
                let nsError = error as NSError
                fatalError("\(nsError), \(nsError.userInfo)")
            }
        }
    }
}
