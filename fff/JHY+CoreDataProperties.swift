//
//  JHY+CoreDataProperties.swift
//  fff
//
//  Created by BST-MAC on 2018/5/25.
//  Copyright © 2018年 BST-MAC. All rights reserved.
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

}
