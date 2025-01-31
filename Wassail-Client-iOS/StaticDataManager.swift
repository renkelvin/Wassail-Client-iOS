//
//  StaticDataManager.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 10/27/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

private let _StaticDataManagerSharedInstance = StaticDataManager()

class StaticDataManager: NSObject {
    
    class var instance : StaticDataManager {
        return _StaticDataManagerSharedInstance
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.haile.TestCoreData" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
        }()
    
    lazy var applicationCachesDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.haile.TestCoreData" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("WassailModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationCachesDirectory.URLByAppendingPathComponent("Static.sqlite")
        
        // ***v1.2.1*** Force copy static dota store
        let bo = NSUserDefaults.standardUserDefaults().boolForKey("staticDataStoreDidCopy121") as Bool
        if (true) {
            let urlRes = NSBundle.mainBundle().URLForResource("Static", withExtension: "sqlite")
            if (urlRes != nil) {
                do {
                    try NSFileManager.defaultManager().removeItemAtURL(url)
                } catch _ {
                }
                do {
                    try NSFileManager.defaultManager().copyItemAtURL(urlRes!, toURL: url)
                } catch _ {
                }
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "staticDataStoreDidCopy121")
            }
        }
        
        // Copy static dota store from resource
        if (!NSFileManager.defaultManager().fileExistsAtPath(url.path!)) {
            let urlRes = NSBundle.mainBundle().URLForResource("Static", withExtension: "sqlite")
            if (urlRes != nil) {
                do {
                    try NSFileManager.defaultManager().copyItemAtURL(urlRes!, toURL: url)
                } catch _ {
                }
            }
        }

        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: "Static", URL: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            // error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            error = nil
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch let error1 as NSError {
                    error = error1
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
            }
        }
    }
    
}
