//
//  ListTableViewSimple54Cell.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 10/26/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

class ListTableViewSimple54Cell: ListTableViewCell {
   
    override func configure(item: HLItemPreview) {
        titleLabel?.text = item.title as? String
        noteLabel?.text = item.note as? String
    }
    
}
