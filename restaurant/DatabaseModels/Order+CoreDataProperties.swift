//
//  Order+CoreDataProperties.swift
//  restaurant
//
//  Created by Ewa Solarska on 28/08/2023.
//
//

import Foundation
import CoreData


extension Order {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }
    
    @NSManaged public var address: String?
    @NSManaged public var date: Date?
    @NSManaged public var status: String?
    @NSManaged public var surname: String?
    @NSManaged public var toOrderedProduct: NSSet?
    
    public var orderedProductArray: [OrderedProduct] {
        let set = toOrderedProduct as? Set<OrderedProduct> ?? []
        
        return set.sorted{
            $0.quantity > $1.quantity
        }
    }
    
    public var totalCost: Double {
        let orderedProducts = toOrderedProduct as? Set<OrderedProduct> ?? []
        
        return orderedProducts.reduce(0) { (result, orderedProduct) -> Double in
            return result + (Double(orderedProduct.quantity) * (orderedProduct.toProduct?.price ?? 0.0))
        }
    }
}

// MARK: Generated accessors for toOrderedProduct
extension Order {

    @objc(addToOrderedProductObject:)
    @NSManaged public func addToToOrderedProduct(_ value: OrderedProduct)

    @objc(removeToOrderedProductObject:)
    @NSManaged public func removeFromToOrderedProduct(_ value: OrderedProduct)

    @objc(addToOrderedProduct:)
    @NSManaged public func addToToOrderedProduct(_ values: NSSet)

    @objc(removeToOrderedProduct:)
    @NSManaged public func removeFromToOrderedProduct(_ values: NSSet)

}

extension Order : Identifiable {

}
