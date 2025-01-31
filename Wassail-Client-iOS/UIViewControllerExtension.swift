//
//  UIViewControllerExtension.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 9/12/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setInfo(info: AnyObject?) {
        
    }
    
    enum HLNavigationBarStyle {
        case Default
        case Transparent
        case TransparentWithDarkText
        case Blue
    }
    
    func setNavigationBarStyle(style: HLNavigationBarStyle) {
        if (self.navigationController == nil) {
            return
        }
        
        let bar = self.navigationController!.navigationBar as UINavigationBar
        
        switch style {
        case .Default:
            bar.barTintColor = nil
            bar.tintColor = UIColor.HLBlue(0).makeTranslucent()
            bar.barStyle = UIBarStyle.Default
            bar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
            //            bar.shadowImage = UIImage()
            bar.backgroundColor = UIColor.clearColor()
        case .Transparent:
            bar.barTintColor = nil
            bar.tintColor = UIColor.whiteColor()
            bar.barStyle = UIBarStyle.Black
            bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            //            bar.shadowImage = UIImage()
            bar.backgroundColor = UIColor.clearColor()
        case .TransparentWithDarkText:
            bar.barTintColor = nil
            bar.tintColor = UIColor.HLBlue(0).makeTranslucent()
            bar.barStyle = UIBarStyle.Default
            bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            //            bar.shadowImage = UIImage()
            bar.backgroundColor = UIColor.clearColor()
        case .Blue:
            bar.barTintColor = UIColor.HLBlue(0).makeTranslucent()
            bar.tintColor = UIColor.whiteColor()
            bar.barStyle = UIBarStyle.Black
            bar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
            //            bar.shadowImage = UIImage()
            bar.backgroundColor = UIColor.clearColor()
        }
    }
}
