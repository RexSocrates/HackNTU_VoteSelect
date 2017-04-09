//
//  WallPostTableViewCell.swift
//  VoteSelect
//
//  Created by BEN on 16/1/2016.
//  Copyright © 2016年 8en7am1n. All rights reserved.
//

import UIKit

class WallPostTableViewCell: PFTableViewCell {
    
    
    
    var yellowNum = 0
    var greenNum = 0
    var redNum = 0
    var blueNum = 0
    
    
    
    @IBOutlet weak var voteYellow: UILabel!
    @IBOutlet weak var voteGreen: UILabel!
    @IBOutlet weak var voteRed: UILabel!
    @IBOutlet weak var voteBlue: UILabel!
    
    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    @IBOutlet weak var yellowButtonVar: UIButton!
    @IBOutlet weak var greenButtonVar: UIButton!
    @IBOutlet weak var redButtonVar: UIButton!
    @IBOutlet weak var blueButtonVar: UIButton!
    
    
    
    //point label
    @IBOutlet weak var yellowPointLabel: UILabel!
    @IBOutlet weak var greenPointLabel: UILabel!
    @IBOutlet weak var redPointLabel: UILabel!
    @IBOutlet weak var bluePointLabel: UILabel!
    
//    var parseObject:PFObject?
    
    @IBAction func buttonOnImageInside(sender: AnyObject) {
        //touch down
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.timeLabel.text = "發佈時間:23/01 2016"
            
            self.greenPointLabel.alpha = 0
            self.redPointLabel.alpha = 0
            self.yellowPointLabel.alpha = 0
            self.bluePointLabel.alpha = 0
        }
        
    }
    
    
    @IBAction func buttonOnImageOutside(sender: AnyObject) {
        //touch up inside
        UIView.animateWithDuration(0.3) { () -> Void in
            self.timeLabel.text = "結束時間:30/01 2016"
            
//            self.greenPointLabel.alpha = 1
//            self.redPointLabel.alpha = 1
//            self.yellowPointLabel.alpha = 1
//            self.bluePointLabel.alpha = 1
        }
        
    }
    
    func showVotingLabel() {
        var numberArr = [yellowNum, greenNum, redNum, blueNum]
        var labelArr = [self.voteYellow, self.voteGreen, self.voteRed, self.voteBlue]
        for i in 0..<numberArr.count {
            labelArr[i].text = "\(numberArr[i])"
            labelArr[i].alpha = 1
        }
    }
    
    
    
    @IBAction func voteGreenButton(sender: AnyObject) {
        self.greenNum++
        showVotingLabel()
    }
    
    
    @IBAction func voteRedButton(sender: AnyObject) {
        self.redNum++
        showVotingLabel()
    }
    
    
    
    @IBAction func voteYellowButton(sender: AnyObject) {
        self.yellowNum++
        showVotingLabel()
    }
    
    
    @IBAction func voteBlueButton(sender: AnyObject) {
        self.blueNum++
        showVotingLabel()
    }
    
    
    
    
    
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        yellowButtonVar=UIButton(frame: CGRectMake(100, 7, 80, 36))
//        yellowButtonVar.backgroundColor=UIColor.lightGrayColor()
//        self.contentView.addSubview(yellowButtonVar)
//        
//    }
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
    
//    @IBAction func yellowButton(sender: AnyObject) {
//        
//        
//        if(parseObject != nil) {
//            if var votes:Int? = parseObject!.objectForKey("voteYellow") as? Int {
//                votes!++
//                
//                parseObject!.setObject(votes!, forKey: "votes");
//                parseObject!.saveInBackground();
//                print("123")
//                yellowButtonVar.titleLabel!.text = "\(votes!) votes";
//            }
//        }
//    }
  
    
}
