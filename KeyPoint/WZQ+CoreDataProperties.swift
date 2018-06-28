//
//  WZQ+CoreDataProperties.swift
//  
//
//  Created by BST-MAC on 2018/6/26.
//
//

import Foundation
import CoreData


extension WZQ {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WZQ> {
        return NSFetchRequest<WZQ>(entityName: "WZQ")
    }

    @NSManaged public var cid: String?
    @NSManaged public var wzqname: String?
    @NSManaged public var master_jhy: JHY?

}
