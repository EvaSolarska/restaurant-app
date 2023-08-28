//
//  OrderedProduct+CoreDataProperties.swift
//  restaurant
//
//  Created by Ewa Solarska on 28/08/2023.
//
//

import Foundation
import CoreData


extension OrderedProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderedProduct> {
        return NSFetchRequest<OrderedProduct>(entityName: "OrderedProduct")
    }

    @NSManaged public var quantity: Int16
    @NSManaged public var toOrder: Order?
    @NSManaged public var toProduct: Product?

}

extension OrderedProduct : Identifiable {

}
