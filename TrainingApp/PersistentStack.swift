//
//  PersistentStack.swift
//  TrainingApp
//
//  Created by Bartłomiej Hyży on 29/12/15.
//
//

import Foundation
import CoreData

// TODO: error domains and codes
class PersistentStack {
    
    let storeURL: NSURL
    let modelURL: NSURL
    
    let managedObjectModel: NSManagedObjectModel
    let persistentStoreCoordinator: NSPersistentStoreCoordinator
    let managedObjectContext: NSManagedObjectContext
    
    init(storeURL: NSURL, modelURL: NSURL) throws {
        self.storeURL = storeURL
        self.modelURL = modelURL
        
        managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)!
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        do {
            try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = "There was an error creating or loading the application's saved data."
            dict[NSUnderlyingErrorKey] = error as NSError
            
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            throw wrappedError
        }
    }
    
    func saveContext() throws {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                var dict = [String: AnyObject]()
                dict[NSLocalizedDescriptionKey] = "Failed to save the application's data"
                dict[NSLocalizedFailureReasonErrorKey] = "There was an error saving the application's data context."
                dict[NSUnderlyingErrorKey] = error as NSError
                
                let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
                throw wrappedError
            }
        }
    }
    
}
