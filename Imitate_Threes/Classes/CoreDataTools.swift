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
    
    static let sharedInstance = CoreDataTools()
    var modelName = "Imitate_Threes"
    var storeFileName = "Imitate_Threes"
    var storeType = "sqlite"
    var storeExtension = "momd"
    
    
    
    
    func save() {
        if managedObjectMainContext.hasChanges {
            try? managedObjectMainContext.save()
        }
    }
    
    func load<T:NSFetchRequestResult>(entityName:String) -> [T]? {
        let request = NSFetchRequest<T>.init(entityName: "Score")
        let result = try? managedObjectMainContext.execute(request) as! NSAsynchronousFetchResult<T>
        return result?.finalResult
    }
    
    func delete<T:NSManagedObject>(Object:T) {
        managedObjectMainContext.delete(Object)
    }
    
    func search<T:NSFetchRequestResult>(entityName:String,sort:[NSSortDescriptor]?,ascending:Bool,predicate:NSPredicate?) -> [T]? {
        let request = NSFetchRequest<T>.init(entityName: entityName)
        request.sortDescriptors = sort
        request.predicate = predicate
        let result = try? managedObjectMainContext.execute(request) as! NSAsynchronousFetchResult<T>
        return result?.finalResult
    }
    
    
    
    
    
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
            
            _ = try? storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: fileURL, options: options)
            
            return storeCoordinator
        }
    }
    
    var managedObjectModel:NSManagedObjectModel {
        get {
            let fileURL = Bundle.main.url(forResource: storeFileName, withExtension: storeExtension)
            let model = NSManagedObjectModel.init(contentsOf: fileURL!)!
            return model
        }
    }
    
    func applicationDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last!
    }
    
}
