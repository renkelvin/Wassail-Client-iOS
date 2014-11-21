//
//  UniversityRankingTableViewCell.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 10/26/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

class UniversityRankingTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var subtitleLabel: UILabel?
    @IBOutlet var noteLabel: UILabel?
    @IBOutlet var iconImageView: UIImageView?
    
    @IBOutlet var scoreLabel: UILabel?
    @IBOutlet var rankLabel: UILabel?
    
    func configure(item: HLUniversityPreviewWithRank) {
        titleLabel?.text = item.title
        noteLabel?.text = item.note
        subtitleLabel?.text = item.chineseName
        
        if (item.score == nil || item.score! == 0.0) {
            scoreLabel?.hidden = true
        }
        else {
            scoreLabel?.text = NSString(format: "%.3g", item.score!)
        }
        
        rankLabel?.text = String(item.rank!)
        
        let name = item.icon!.address
        if (name != nil) {
            iconImageView?.sd_setImageWithURL(NSURL(string: name!), placeholderImage: UIImage(named: "ImagePlaceHolder"))
        }
    }
    
}
