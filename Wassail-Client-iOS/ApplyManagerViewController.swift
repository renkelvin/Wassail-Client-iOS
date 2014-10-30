//
//  ApplyManagerViewController.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 10/23/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

class ApplyManagerViewController: GAITrackedViewController {
    
    let info: ApplyManagerInfo = ApplyManagerInfo.instance
    
    @IBOutlet var navigationView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //
        info.reloadData()
        
        // GAITrackedViewController name
        self.screenName = "Apply Manager Screen"
        
        // Configure Navigation Bar and Status Bar
        self.setNavigationBarStyle(HLNavigationBarStyle.Transparent)
        navigationView!.backgroundColor! = UIColor.HLBlue(0)
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        let array = info.getAllApplies()
        return array!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ApplyManagerTableViewCellReuseIdentifier", forIndexPath: indexPath) as ApplyManagerTableViewCell
        
        // Configure the cell
        let array = info.getAllApplies()
        let apply = array!.objectAtIndex(indexPath.row) as HLApply
        
        cell.configure(apply)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
        var headerView = NSBundle.mainBundle().loadNibNamed("RKTableHeaderView", owner: nil, options: nil).first as RKTableHeaderView
        
        var title: String = ""
        switch section {
        case 0:
            title = "申请列表"
        default:
            title = ""
        }
        
        headerView.titleLabel?.text = title
        
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Deselect
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //
        let array = info.getAllApplies()
        let apply = array!.objectAtIndex(indexPath.row) as HLApply

        self.performSegueWithIdentifier("ApplyManagerApplySegueIdentifier", sender: apply)
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        var controller = segue.destinationViewController as UIViewController
        controller.setInfo(sender)
    }
    
}
