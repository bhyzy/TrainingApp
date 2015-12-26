//
//  TestDataGenerator.swift
//  TrainingApp
//
//  Created by Bartłomiej Hyży on 26/12/15.
//
//

import Foundation
import CoreData

class TestDataGenerator {
    
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func generateData() {
        Training.create("Test training", inContext: context)
        Training.create("Another training", inContext: context)
        Training.create("Regeneration", inContext: context)
    }
    
    class func shouldGenerateDataForContext(context: NSManagedObjectContext) -> Bool {
        return Training.countTrainingsInContext(context) == 0
    }
    
}