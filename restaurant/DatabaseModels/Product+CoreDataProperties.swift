//
//  Product+CoreDataProperties.swift
//  restaurant
//
//  Created by Ewa Solarska on 28/08/2023.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var desc: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var toCategory: Category?
    @NSManaged public var toOrderedProduct: NSSet?

    public var orderedProductArray: [OrderedProduct] {
        let set = toOrderedProduct as? Set<OrderedProduct> ?? []
        
        return set.sorted{
            $0.quantity > $1.quantity
        }
    }
}

// MARK: Generated accessors for toOrderedProduct
extension Product {

    @objc(addToOrderedProductObject:)
    @NSManaged public func addToToOrderedProduct(_ value: OrderedProduct)

    @objc(removeToOrderedProductObject:)
    @NSManaged public func removeFromToOrderedProduct(_ value: OrderedProduct)

    @objc(addToOrderedProduct:)
    @NSManaged public func addToToOrderedProduct(_ values: NSSet)

    @objc(removeToOrderedProduct:)
    @NSManaged public func removeFromToOrderedProduct(_ values: NSSet)

}

extension Product : Identifiable {

}
