//
//  UnitConverterViewController.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 9/8/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

class UnitConverterViewController: GAITrackedViewController, UITableViewDataSource, UITableViewDelegate, RKPickerViewDelegate {
    
    let info: UnitConverterInfo = UnitConverterInfo.instance
    
    var ci: Int = 0
    var iu: NSDictionary?
    var ou: NSDictionary?
    
    var input: Double = 1.0
    @IBOutlet var inputTextField: UITextField?
    @IBOutlet var inputUnitLabel: UILabel?
    @IBOutlet var keyboardAccessoryView: UIView?
    @IBOutlet var zeroBarButtonItem: UIBarButtonItem?
    
    var output: Double = 0.0
    @IBOutlet var outputTextField: UITextField?
    @IBOutlet var outputUnitLabel: UILabel?
    
    @IBOutlet var selectorView: RKSelectorView?
    
    @IBOutlet var leftPickerView: RKPickerView?
    @IBOutlet var rightPickerView: RKPickerView?
    
    @IBOutlet var dataView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        info.reloadData()
        
        iu = info.getUnit(ci, ui: 0)
        ou = info.getUnit(ci, ui: 0)
        self.updateNumbersByInput()
        
        leftPickerView!.delegate = self
        leftPickerView!.tag = 0
        rightPickerView!.delegate = self
        rightPickerView!.tag = 1
        
        inputTextField!.inputAccessoryView = keyboardAccessoryView
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // GAITrackedViewController name
        self.screenName = "Unit Converter Screen"
        
        // Configure Navigation Bar and Status Bar
        self.setNavigationBarStyle(HLNavigationBarStyle.Transparent)
        self.selectCategory(0)
        self.updateNumbersByInput()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // inputTextField!.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    
    func selectCategory(number: Int) {
        
        ci = number
        iu = info.getUnit(ci, ui: 0)
        ou = info.getUnit(ci, ui: 1)
        
        let units = info.getUnits(ci)
        if (units == nil) {
            return
        }
        
        selectorView!.reloadData()
        
        dataView!.reloadData()
        
        leftPickerView!.reload(units!)
        rightPickerView!.reload(units!)
        
        //
        let string = inputTextField!.text! as NSString
        if (string.length > 1 && string.substringToIndex(1) == "-") {
            inputTextField!.text = string.substringFromIndex(1)
            input = NSString(string: inputTextField!.text!).doubleValue
        }
        
        //
        zeroBarButtonItem!.title = nil
        if (number == 4) {
            zeroBarButtonItem!.title = "零下"
        }
    }
    
    func updateViews() {
        
        inputTextField!.text = String(format: "%g", input)
        outputTextField!.text = String(format: "%g", output)
        
        inputUnitLabel!.text = iu!.objectForKey("unit") as! NSString as String
        outputUnitLabel!.text = ou!.objectForKey("unit") as! NSString as String
    }
    
    func updateNumbersByInput() {
        
        output = convert(input)
        
        self.updateViews()
    }
    
    func convert(input: Double) -> Double {
        if (iu == nil) {
            return 0.0
        }
        if (ou == nil) {
            return 0.0
        }
        
        let k1: Double = (iu!.objectForKey("k") as! NSString).doubleValue
        let b1: Double = (iu!.objectForKey("b") as! NSString).doubleValue
        
        let k2: Double = (ou!.objectForKey("k") as! NSString).doubleValue
        let b2: Double = (ou!.objectForKey("b") as! NSString).doubleValue
        
        let output = (k1*input+b1-b2)/k2
        return output
    }
    
    // MARK: - IBAction
    
    @IBAction func doneButtonTapped() {
        inputTextField!.resignFirstResponder()
    }
    
    @IBAction func zeroButtonTapped() {
        
        input = NSString(string: inputTextField!.text!).doubleValue * (-1.0)
        
        if (input > 0) {
            zeroBarButtonItem!.title = "零下"
        }
        else if (input < 0) {
            zeroBarButtonItem!.title = "零上"
        }
        
        self.updateNumbersByInput()
        
    }
    
    // MARK: - TableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch section {
        case 0:
            let knows = info.getKnows(ci)
            return knows!.count
            
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UnitConverterTableViewCellReuseIdentifier", forIndexPath: indexPath) as! UnitConverterTableViewCell
        
        switch indexPath.section {
        case 0:
            let knows = info.getKnows(ci)
            cell.configure(knows![indexPath.row] as! NSDictionary)
            
        default:
            return cell
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = NSBundle.mainBundle().loadNibNamed("RKTableHeaderView", owner: nil, options: nil).first as! RKTableHeaderView
        
        var title: String = ""
        switch section {
        case 0:
            title = "常用换算"
        default:
            title = ""
        }
        headerView.titleLabel?.text = title
        
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Deselect
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return info.numberOfCategories()
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RKSelectorCollectionViewCellReuseIdentifier", forIndexPath: indexPath) as! RKSelectorCollectionViewCell
        
        if (indexPath.row == ci) {
            cell.setSelect()
        }
        else {
            cell.setDeselect()
        }
        
        // Configure the cell
        let names = info.getNames()
        if (names == nil) {
            return cell
        }
        let name = names!.objectAtIndex(indexPath.row) as! NSString
        let dict = info.getCategoryByName(name as String) as NSDictionary?
        cell.configure(dict)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.selectCategory(indexPath.row)
        self.updateNumbersByInput()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = selectorView!.bounds.size.height
        let number = CGFloat(info.numberOfCategories())
        let width = selectorView!.bounds.size.width / number
        
        return CGSize(width: width, height: height)
    }
    
    // MARK: - RKPickerViewDelegate
    
    func pickerView(pickerView pickerView: RKPickerView, didselectedAtIndex i: Int) {
        
        switch pickerView.tag {
        case 0:
            iu = info.getUnit(ci, ui: i)
        case 1:
            ou = info.getUnit(ci, ui: i)
        default:
            return
        }
        
        self.updateNumbersByInput()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        input = NSString(string: textField.text!).doubleValue
        
        self.updateNumbersByInput()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
