//
//  Category+CoreDataProperties.swift
//  restaurant
//
//  Created by Ewa Solarska on 28/08/2023.
//
//

import Foundation
import CoreData


extension Category {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var toProduct: NSSet?
    
    public var productArray: [Product] {
        let set = toProduct as? Set<Product> ?? []
        
        return set.sorted{
            $0.name! < $1.name!
        }
    }
}

// MARK: Generated accessors for toProduct
extension Category {
    
    @objc(addToProductObject:)
    @NSManaged public func addToToProduct(_ value: Product)
    
    @objc(removeToProductObject:)
    @NSManaged public func removeFromToProduct(_ value: Product)
    
    @objc(addToProduct:)
    @NSManaged public func addToToProduct(_ values: NSSet)
    
    @objc(removeToProduct:)
    @NSManaged public func removeFromToProduct(_ values: NSSet)
    
}

extension Category : Identifiable {
    
}
