//
//  Person.swift
//  JustTest
//
//  Created by BST-MAC on 2018/5/16.
//  Copyright © 2018年 BST-MAC. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Dog:Object{
    
//    required init?(map: Map) {
//
//    }
//
//    required init() {
//        fatalError("init() has not been implemented")
//    }
//
//
//    func mapping(map: Map) {
//        name <- map["name"]
//    }
    
    
    //==========================
//    required init(realm: RLMRealm, schema: RLMObjectSchema) {
//        fatalError("init(realm:schema:) has not been implemented")
//    }
//
//    required init(value: Any, schema: RLMSchema) {
//        fatalError("init(value:schema:) has not been implemented")
//    }

    

    @objc dynamic var name:String?
    @objc dynamic var age:Int = 0
    let  owner = LinkingObjects(fromType: Person.self, property: "dogs")
    
    
}

class DogModel: NSObject,Mappable {
    
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        
        name <- map["name"]
        age <- map["age"]
    }
    
    var name:String?
    var age:String?
    
}

class Person: Object {
    
    @objc dynamic  var name:String?
    @objc dynamic var birthData:Date?
    let dogs:List =  List<Dog>()
    
       override class func primaryKey() -> String? {
        
        return "name"
    }
}

class Cat: Object {
    
    @objc dynamic var name:String?
}

