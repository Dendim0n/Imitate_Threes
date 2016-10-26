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
    
    static let modelName = "Imitate_Threes"
    static let storeFileName = "Imitate_Threes"
    static let storeType = "sqlite"
    static let storeExtension = "momd"
    
    
    func save() {
        if managedObjectMainContext.hasChanges {
            try? managedObjectMainContext.save()
        }
    }
    
//    func load<T:NSFetchRequestResult>(entityName:String) -> [T]? {
//        let request = NSFetchRequest<T>.init(entityName: "Score")
//        let result = try? managedObjectMainContext.execute(request) as! NSAsynchronousFetchResult<T>
//        return result?.finalResult
//    }
    
    func delete<T:NSManagedObject>(Object:T) {
        managedObjectMainContext.delete(Object)
        save()
    }
    
    func search<T:NSFetchRequestResult>(entityName:String,sort:[NSSortDescriptor]?,ascending:Bool,predicate:NSPredicate?) -> [T]? {
        let request = NSFetchRequest<T>.init(entityName: entityName)
        request.sortDescriptors = sort
        request.predicate = predicate
        let result = try? managedObjectMainContext.execute(request) as! NSAsynchronousFetchResult<T>
        return result?.finalResult
    }
    
    lazy var managedObjectMainContext:NSManagedObjectContext = {
            let mainContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
            mainContext.persistentStoreCoordinator = self.persistentStoreCoordinator
            return mainContext
    }()
    
    lazy var persistentStoreCoordinator:NSPersistentStoreCoordinator = {
            let storeCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: self.managedObjectModel)
            let options = [NSMigratePersistentStoresAutomaticallyOption:true,NSInferMappingModelAutomaticallyOption:true]
            let fileURL = self.applicationDocumentsDirectory.appendingPathComponent(storeFileName).appendingPathExtension(storeType)
            _ = try? storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: fileURL, options: options)
            return storeCoordinator
    }()
    
    lazy var managedObjectModel:NSManagedObjectModel = {
            let fileURL = Bundle.main.url(forResource: storeFileName, withExtension: storeExtension)
            let model = NSManagedObjectModel.init(contentsOf: fileURL!)!
            return model
    }()
    
    lazy var applicationDocumentsDirectory:URL = {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last!
    }()
    
}
