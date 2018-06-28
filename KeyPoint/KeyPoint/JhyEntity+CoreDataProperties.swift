//
//  JhyEntity+CoreDataProperties.swift
//  
//
//  Created by BST-MAC on 2018/6/28.
//
//

import Foundation
import CoreData


extension JhyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JhyEntity> {
        return NSFetchRequest<JhyEntity>(entityName: "JhyEntity")
    }

    @NSManaged public var name: String?

}
