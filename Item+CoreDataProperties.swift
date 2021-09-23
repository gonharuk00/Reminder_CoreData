//
//  Item+CoreDataProperties.swift
//  Reminder
//
//  Created by Alex Honcharuk on 11.09.2021.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String
    @NSManaged public var comleted: Bool
    @NSManaged public var category: Category

}

extension Item : Identifiable {

}
