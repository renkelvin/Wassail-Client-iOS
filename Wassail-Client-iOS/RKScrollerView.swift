//
//  RKScrollerView.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 9/18/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

class RKScrollerView: UIScrollView {
    
    var indent: Double = 0.0
    var itemWidth: Double = 48.0
    
    func generateLabels() {
        
        var cur: Double = 0.0
        for i in 0...99 {
            let label = UILabel()
            
            label.font = UIFont.boldSystemFontOfSize(32.0)
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.whiteColor()
            label.text = String(i)
            
            _ = label.frame.size
            label.frame = CGRect(origin: CGPoint(x: cur, y: 8), size: CGSize(width: CGFloat(itemWidth), height: 38.0))
            cur += itemWidth
            
            self.addSubview(label)
        }
    }
    
    func configure() {
        
        self.generateLabels()
        
        let width = itemWidth * 100
        self.contentSize = CGSize(width: width, height: 54)
        
        self.contentInset = UIEdgeInsets(top: 0.0, left: CGFloat(indent), bottom: 0.0, right: CGFloat(indent))
        
    }
    
    func setIndent() {
       
        self.indent = (Double(self.frame.size.width) - itemWidth) / 2.0

    }
    
    func getRate() -> Double {
        let rate = (Double(self.contentOffset.x) + indent) / itemWidth
        
        return rate / 100.0
    }
    
    func scrollTo(rate: Double) {
        
        let x: Double = itemWidth * rate * 100 - indent
        
        // TODO: > 99
        
        self.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        
    }
}
