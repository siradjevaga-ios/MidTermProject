//
//  WishEntity+CoreDataProperties.swift
//  MidTermProject
//
//  Created by user on 09.01.26.
//
//

public import Foundation
public import CoreData


public typealias WishEntityCoreDataPropertiesSet = NSSet

extension WishEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishEntity> {
        return NSFetchRequest<WishEntity>(entityName: "WishEntity")
    }

    @NSManaged public var userId: Int64
    @NSManaged public var productId: Int64

}

extension WishEntity : Identifiable {
    
}
