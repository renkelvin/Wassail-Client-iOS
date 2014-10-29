//
//  ApplyManagerTableViewCell.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 10/28/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

class ApplyManagerTableViewCell: UITableViewCell, UIActionSheetDelegate {
    
    @IBOutlet var iconImageView: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var noteLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    
    @IBOutlet var statusButton: RKApplyButton?
    
    var item: HLApply?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - IBAction
    
    @IBAction func statusButtonClicked() {
        let actionSheet = KKActionSheet(title: "选择申请状态", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
        
        actionSheet.addButtonWithTitle("正在申请")
        actionSheet.addButtonWithTitle("申请完成")
        actionSheet.addButtonWithTitle("已被录取")
        actionSheet.addButtonWithTitle("已被拒绝")
        
        actionSheet.setTextColor(UIColor.HLYellow(0), forButtonIndex: 2)
        
        actionSheet.showInView(self)
    }
    
    // MARK: -
    
    func configure(item: HLApply) {
        
        self.item = item
        
        self.updateView()
    }
    
    func updateView() {
        
        let programInstanceId = item!.programInstanceId as NSNumber
        
        let preview = ApplyAccessor.instance.getProgramInstancePreviewByProgramInstanceId(programInstanceId) as HLProgramInstancePreview?
        
        titleLabel!.text = preview!.universityName
        noteLabel!.text = preview!.programName
        // dateLabel!.text = preview!.deadlineDate.description
        
        let imageArray = [
            "https://d17l1xohxe6z0o.cloudfront.net/a2/institute/berkeley/logo.png",
            "https://d17l1xohxe6z0o.cloudfront.net/a2/institute/ca.utoronto/logo.png",
            "https://d17l1xohxe6z0o.cloudfront.net/a2/institute/caltech/logo.png",
            "https://d17l1xohxe6z0o.cloudfront.net/a2/institute/stanford/logo.png",
            "https://d17l1xohxe6z0o.cloudfront.net/a2/institute/uk.ox/logo.png"
        ]
        let s = imageArray[random()%5] as NSString
        iconImageView!.sd_setImageWithURL(NSURL(string: s), placeholderImage: UIImage(named: "ImagePlaceHolder"))

        statusButton!.setStatus(item!.status.integerValue)
    }
    
    // MARK: - UIActionSheetDelegate
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        switch buttonIndex {
        case 0:
            ""
        case 1:
            item!.status = 1
        case 2:
            item!.status = 2
        case 3:
            item!.status = 3
        case 4:
            item!.status = 4
        default:
            ""
        }
        
        self.updateView()
    }
    
}
