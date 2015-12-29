//
//  AppDelegate.swift
//  TrainingApp
//
//  Created by Bartłomiej Hyży on 26/12/15.
//
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        do {
            let storeURL = applicationDocumentsDirectory.URLByAppendingPathComponent("Trainings.sqlite")
            let modelURL = NSBundle.mainBundle().URLForResource("TrainingApp", withExtension: "momd")!
            try persistentStack = PersistentStack(storeURL: storeURL, modelURL: modelURL)
            
            if TestDataGenerator.shouldGenerateDataForContext(persistentStack.managedObjectContext) {
                let generator = TestDataGenerator(context: persistentStack.managedObjectContext)
                generator.generateData()
                try persistentStack.saveContext()
            }
        } catch {
            NSLog("Unresolved error \(error)")
            abort()
        }
        
        return true
    }

    func applicationDidEnterBackground(application: UIApplication) {
        do {
            try persistentStack.saveContext()
        } catch {
            NSLog("Unresolved error \(error)")
            abort()
        }
    }

    // MARK: - Persistent stack
    
    var persistentStack: PersistentStack!

    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

}

