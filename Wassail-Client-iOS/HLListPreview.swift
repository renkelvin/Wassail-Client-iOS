//
//  HLListPreview.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 9/13/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

class HLListPreview: HLItemPreview {
    
    override init(json: NSDictionary) {
        super.init(json: json)
        
        sourceType = "List"
    }

}