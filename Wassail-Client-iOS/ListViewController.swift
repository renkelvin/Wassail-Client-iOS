//
//  ListViewController.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 9/12/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

class ListViewController: GAITrackedViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView?
    
    @IBOutlet var navigationView: UIView?
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var authorLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    
    @IBOutlet var headerLabel: UILabel?
    @IBOutlet var headerContainer: UIView?
    @IBOutlet var headerLabelPrototype: UILabel?
    
    @IBOutlet var footerLabel: UILabel?
    
    var listName: NSString?
    var list: HLList?
    
    var offscreenCells: NSMutableDictionary = NSMutableDictionary()
    var cellHeights: NSMutableDictionary = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reload data
        self.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // GAITrackedViewController name
        self.screenName = "List Screen"
        
        // Configure Navigation Bar and Status Bar
        self.setNavigationBarStyle(HLNavigationBarStyle.Transparent)
        navigationView!.backgroundColor! = UIColor.HLBlue(0)
    }
    
    // MARK: -
    
    override func setInfo(info: AnyObject?) {
        if (info != nil) {
            listName = info as? NSString
        }
    }
    
    func reloadData() {
        
        if (listName == nil) {
            return
        }
        
        list = ListInfo.instance.getList(listName! as String)
        
        if (list == nil) {
            return
        }
        
        // Set list title
        self.title = list!.title as? String
        
        self.updateTableHeader()
        
    }
    
    func updateTableHeader() {
        
        if (list == nil) {
            return
        }
        
        self.headerLabel!.text = list!.header as? String
        
        let height: CGFloat = self.getHeaderHeight(list!.header)
        
        if (height == 0) {
            self.tableView!.tableHeaderView = nil
        }
        else {
            self.tableView!.tableHeaderView!.frame.size.height = height + 52.0
        }
        
        self.footerLabel!.text = list!.footer as? String
    }
    
    func getHeaderHeight(text: NSString?) -> CGFloat {
        
        if (text == nil) {
            return 0.0
        }
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ListViewController") as! ListViewController
        let label = controller.headerLabelPrototype!
        label.frame.size.width = DefaultInfo.instance.getScreenWidth() - 50.0
        label.text = text! as String
        
        label.sizeToFit()
        
        return label.frame.height
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        if (list == nil) {
            return 0
        }
        
        return list!.numberOfGroups()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if (list == nil) {
            return 0
        }
        
        return list!.numberOfItemsInGroup(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (list == nil) {
            return UITableViewCell()
        }
        
        let item = list!.item(indexPath.section, row: indexPath.row)
        if (item == nil) {
            return UITableViewCell()
        }
        if (!item!.isKindOfClass(HLItemPreview)) {
            print("Wrong list item: \(item!)")
            return UITableViewCell()
        }
        
        var cellReuseIdentifier = "ListTableViewSimple44CellReuseIdentifier"
        
        if (((item as! HLItemPreview).icon) != nil) {
            cellReuseIdentifier = "ListTableView54CellReuseIdentifier"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! ListTableViewCell
        cell.configure(item as! HLItemPreview)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // TODO: manaully adjust cell height
        let h = self.cellHeights.objectForKey(indexPath) as! CGFloat?
        if (h != nil) {
            return h!
        }
        
        if (list == nil) {
            return 0.0
        }
        
        let item = list!.item(indexPath.section, row: indexPath.row)
        if (item == nil) {
            return 0.0
        }
        if (!item!.isKindOfClass(HLItemPreview)) {
            print("Wrong list item: \(item!)")
            return 0.0
        }
        
        var height: CGFloat = 0.0
        
        if (((item as! HLItemPreview).icon) != nil) {
            height = 54.0
        }
        else {
            height = 44.0
        }
        
        self.cellHeights.setObject(height+1, forKey: indexPath)
        return height+1
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let h = self.cellHeights.objectForKey(indexPath) as! CGFloat?
        if (h != nil) {
            return h!
        }
        
        return 54.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = NSBundle.mainBundle().loadNibNamed("RKTableHeaderView", owner: nil, options: nil).first as! RKTableHeaderView
        
        if (list == nil) {
            return headerView
        }
        
        let title: String = list!.titleForGroup(section) as String
        
        headerView.setTitle(title)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (list == nil) {
            return 0.0
        }
        
        let title: String = list!.titleForGroup(section) as String
        
        if (title == "-" || title == "~") {
            return 0.0
        }
        
        return 20.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Deselect
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Get source item
        if (list == nil) {
            return
        }
        
        let itemPreview = list!.item(indexPath.section, row: indexPath.row) as! HLItemPreview
        
        if (itemPreview.sourceType == nil) {
            return
        }
        let segueIdentifier = "List" + (itemPreview.sourceType! as String) + "SegueIdentifier"
        self.performSegueWithIdentifier(segueIdentifier, sender: itemPreview.address)

    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let controller = segue.destinationViewController as UIViewController
        controller.setInfo(sender)
    }
    
}
