//
//  DatabaseAdapter.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 9/21/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

enum Context {
    case Static
    case User
}

private let _DatabaseAdapterSharedInstance = DatabaseAdapter()

class DatabaseAdapter: NSObject {
    
    class var instance : DatabaseAdapter {
        return _DatabaseAdapterSharedInstance
    }
    
    func createObject(entityName: NSString, contextType: Context) -> NSManagedObject? {
        
        var context: NSManagedObjectContext?
        
        switch contextType {
        case .Static:
            context = StaticDataManager.instance.managedObjectContext
        case .Static:
            context = StaticDataManager.instance.managedObjectContext
        default:
            context = nil
        }
        
        
        
        
        return nil
    }
    
    
}
