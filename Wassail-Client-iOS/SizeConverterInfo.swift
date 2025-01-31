//
//  SizeConverterInfo.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 9/16/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

private let _SizeConverterInfoSharedInstance = SizeConverterInfo()

class SizeConverterInfo: NSObject {
    
    var data: NSDictionary?
    
    class var instance : SizeConverterInfo {
    return _SizeConverterInfoSharedInstance
    }
    
    func reloadData() {
        data = DefaultAccessor.instance.getSizeConverter() as NSDictionary?
    }
    
    func numberOfCategories() -> Int {
        if (data == nil) {
            return 0
        }
        
        return self.getNames()!.count
    }
    
    func getCategoryByName(name: String) -> NSDictionary? {
        if (data == nil) {
            return nil
        }
        
        return data!.objectForKey(name) as? NSDictionary
    }
    
    func getCategory(index: Int) -> NSDictionary? {
        if (data == nil) {
            return nil
        }
        
        let names = self.getNames()
        if (names == nil) {
            return nil
        }
        
        let name = names![index] as! NSString
        return data!.objectForKey(name) as? NSDictionary
    }
    
    func getNames() -> NSArray? {
        if (data == nil) {
            return nil
        }
        
        return data!.objectForKey("names") as? NSArray
    }
    
    func getHeader(index: Int) -> NSArray? {
        
        let category = self.getCategory(index)
        
        if (category == nil) {
            return nil
        }
        
        return category!.objectForKey("header") as! NSArray?
    }
    
    func getMySize(num: Int) -> NSDictionary? {
        
        let names = self.getNames() as NSArray?
        if (names == nil) {
            return nil
        }
        
        let key = NSString(format: "mysize\(names![num] as! String)")
        
        return UserAccessor.instance.getMySize(key as String)

    }
    
    func setMySize(ci: Int, group: Int, row: Int) -> Bool {
        
        let names = self.getNames() as NSArray?
        if (names == nil) {
            return false
        }
        
        let key = NSString(format: "mysize\(names![ci] as! String)")
        let value = NSDictionary(dictionary: ["group": group, "row": row])
        
        return UserAccessor.instance.setMySize(key, value: value)
    }
    
    func getRow(category: Int, group: Int, row: Int) -> NSArray? {
        let category = self.getCategory(category)
        if (category == nil) {
            return nil
        }
        
        let groups = category!.objectForKey("groups") as! NSArray
        let group = groups[group] as! NSDictionary
        
        let rows = group.objectForKey("rows") as! NSArray
        let row = rows[row] as! NSArray
        
        return row
    }
    
}
