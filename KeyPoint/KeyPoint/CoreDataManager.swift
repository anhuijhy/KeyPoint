//
//  CoreDataManager.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/27.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import CoreData


class CoreDataManager: NSObject {
    
    lazy var objectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
        return context
    }()
    
    lazy var coordinate: NSPersistentStoreCoordinator = {
        let storeURL = self.fileDocPath().appendingPathComponent("coreData.sqlite")
        let coordinate = NSPersistentStoreCoordinator.init(managedObjectModel: self.objeectModel)
        do {
            try coordinate.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: [NSMigratePersistentStoresAutomaticallyOption:true,NSMigratePersistentStoresAutomaticallyOption:true])
        } catch let e{
            
            print("the err is \(e)")
        }
        return coordinate
    }()
    
    lazy var objeectModel: NSManagedObjectModel = {
        
        let objectM = NSManagedObjectModel.init(contentsOf: Bundle.main.url(forResource: "coreData", withExtension: "momd")!)
        return objectM!
    }()
    static let manager = CoreDataManager()
    fileprivate override init() {
        
    }
    
}


extension CoreDataManager{
    /// doc沙盒
    func fileDocPath() -> URL {
        
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }
    
    /// 删除某一Entiry下的所有数据
    ///
    /// - Parameter entity: <#entity description#>
    func deleteAllEntityData(_ entityClass:NSManagedObject, entityName name:String){
        
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName:name)
        request.includesPropertyValues = true
        
        let asyRequest = NSAsynchronousFetchRequest(fetchRequest: request) { (result:NSAsynchronousFetchResult) in
            
            let fetchObject = result.finalResult
            
            guard let _ = fetchObject else { return }
            
            for c in fetchObject!{
                
                CoreDataManager.manager.objectContext.delete(c as! NSManagedObject)
                
            }
            
        }
        
        do {
            
            try CoreDataManager.manager.objectContext.execute(asyRequest)
            
        } catch  {
            
            print("error")
            
        }
        
        
    }
}

extension CoreDataManager{
    
    //增加
    func addEntity(_ entityName:String) -> Void{
        //==Method One
        let Entity = NSEntityDescription.entity(forEntityName: entityName, in: CoreDataManager.manager.objectContext)
        let classEntity = NSManagedObject(entity: Entity!, insertInto: CoreDataManager.manager.objectContext)
        
        classEntity.setValue("Jason", forKey: "name")
        
            //保存实体对象
//            try CoreDataManager.manager.objectContext.save()
            CoreDataManager.manager.saveContext()

        //==Method Two
        //          let jhye = JhyEntity.init(entity: NSEntityDescription.entity(forEntityName: "JhyEntity", in: CoreDataManager.manager.objectContext)!, insertInto: CoreDataManager.manager.objectContext)
        
    }
    
}

extension CoreDataManager{
    
    //===改
    func modifyEntityData(_ entityClass:NSManagedObject, entityName name:String){
        
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName:name)
        request.predicate = NSPredicate(format: "name = jhy", "")
        
        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: request) { (result: NSAsynchronousFetchResult!) in
            
            let fetchObject  = result.finalResult! as! [JhyEntity]
            
            for c  in fetchObject{
                
                c.name = "qazwertdfxcvg"
                CoreDataManager.manager.saveContext()
                
            }
        }
        
        // 执行异步请求调用execute
        do {
            
            try CoreDataManager.manager.objectContext.execute(asyncFecthRequest)
            
        } catch  {
            
            print("error")
        }
    }
}

/// 批量修改
extension CoreDataManager{
    
    func batchUpdate(_ entityName:String) -> Void {
        
        //批量修改
        let batchUpdate = NSBatchUpdateRequest(entityName: "Class")
        //所要更新的属性 和 更新的值
        batchUpdate.propertiesToUpdate = ["name": 55555]
        //被影响的Stores
        batchUpdate.affectedStores = CoreDataManager.manager.coordinate.persistentStores
        //配置返回数据的类型
        batchUpdate.resultType = .updatedObjectsCountResultType
        //执行批量更新
        do {
            
            let batchResult = try CoreDataManager.manager.objectContext.execute(batchUpdate) as! NSBatchUpdateResult
            
            //批量更新的结果，上面resultType类型指定为updatedObjectsCountResultType，所以result显示的为 更新的个数
            
            print("\(batchResult.result!)")
            
        } catch   {
            
            print("error")
            
        }
    }
}

extension CoreDataManager{
    
    func saveContext() -> Void {
        
        if CoreDataManager.manager.objectContext.hasChanges {
            
            do {
                try CoreDataManager.manager.objectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }

    }
}

