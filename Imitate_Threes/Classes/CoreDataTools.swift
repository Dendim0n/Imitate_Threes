//
//  CoreDataTools.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/21.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTools: NSObject {
    
//    typealias Entity = AnyObject
    
    static let sharedInstance = CoreDataTools()
    var modelName = ""
    var storeFileName = "Imitate_Threes"
    var storeType = "momd"
    
    var managedObjectMainContext:NSManagedObjectContext {
        get {
            let mainContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
            mainContext.persistentStoreCoordinator = persistentStoreCoordinator
            return mainContext
        }
    }
    
    var persistentStoreCoordinator:NSPersistentStoreCoordinator {
        get {
            let storeCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: managedObjectModel)
            let options = [NSMigratePersistentStoresAutomaticallyOption:true,NSInferMappingModelAutomaticallyOption:true]
            
            let fileURL = applicationDocumentsDirectory().appendingPathComponent(storeFileName).appendingPathExtension(storeType)
            
//            if !FileManager.default.fileExists(atPath: fileURL.absoluteString) {
//                <#code#>
//            }
            _ = try? storeCoordinator.addPersistentStore(ofType: storeType, configurationName: storeFileName, at: fileURL, options: options)

            return storeCoordinator
        }
    }
    
    var managedObjectModel:NSManagedObjectModel {
        get {
            let fileURL = Bundle.main.url(forResource: storeFileName, withExtension: storeType)
                
//                applicationDocumentsDirectory().appendingPathComponent(modelName).appendingPathExtension("momd")
            let model = NSManagedObjectModel.init(contentsOf: fileURL!)!
            return model
        }
    }
    func save() {
        try? managedObjectMainContext.save()
    }
    func load() -> Array<Score> {
        let request = NSFetchRequest<Score>.init(entityName: "Score")
//        request.predicate = NSPredicate.
//        request.sortDescriptors = [NSSortDescriptor.init(key: "score", ascending: true)]
        let result = try? managedObjectMainContext.execute(request) as! NSAsynchronousFetchResult<Score>
        return (result?.finalResult)!
    }
    func delete() {
        
    }
    
    private func applicationDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last!
    }
    
}
