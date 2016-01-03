//
//  TrainingItem+CoreDataProperties.swift
//  TrainingApp
//
//  Created by Bartłomiej Hyży on 03/01/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TrainingItem {

    @NSManaged var name: String?
    @NSManaged var order: Int64
    @NSManaged var children: NSOrderedSet?
    @NSManaged var parent: TrainingItem?
    @NSManaged var training: Training?

}
