//
//  JHY+CoreDataProperties.swift
//  
//
//  Created by BST-MAC on 2018/6/26.
//
//

import Foundation
import CoreData


extension JHY {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JHY> {
        return NSFetchRequest<JHY>(entityName: "JHY")
    }

    @NSManaged public var m: String?
    @NSManaged public var name: String?
    @NSManaged public var uid: String?
    @NSManaged public var childs: WZQ?

}
