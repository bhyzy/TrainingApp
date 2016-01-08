//
//  Training.swift
//  TrainingApp
//
//  Created by Bartłomiej Hyży on 26/12/15.
//
//

import Foundation
import CoreData


class Training: NSManagedObject {
    
    private static let entityName: String = "Training"

    class func create(name: String, inContext context: NSManagedObjectContext) -> Training {
        let training = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context) as! Training
        training.name = name
        training.order = Int64(countTrainingsInContext(context))
        return training
    }
    
    class func countTrainingsInContext(context: NSManagedObjectContext) -> Int {
        let fetchRequest = NSFetchRequest(entityName: self.entityName)
        fetchRequest.resultType = .CountResultType
        var count = 0
        do {
            let result = try context.executeFetchRequest(fetchRequest)
            count = (result[0] as! NSNumber).integerValue
        } catch {
            NSLog("Failed to fetch Training count: \(error)")
        }
        return count
    }
    
    class func trainingsFetchedResultsControllerForContext(context: NSManagedObjectContext) -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(entityName: self.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    override func prepareForDeletion() {
        let fetchRequest = NSFetchRequest(entityName: Training.entityName)
        fetchRequest.predicate = NSPredicate(format: "order > %@", self.order)
        do {
            let results = try managedObjectContext!.executeFetchRequest(fetchRequest)
            for training in results as! [Training] {
                training.order = training.order - 1
            }
        } catch {
            NSLog("Failed to prepare a Training for deletion: \(error)")
        }
    }
    
}
