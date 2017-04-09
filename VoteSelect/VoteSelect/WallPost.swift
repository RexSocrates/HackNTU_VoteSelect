//
//  WallPost.swift
//  VoteSelect
//
//  Created by BEN on 15/1/2016.
//  Copyright © 2016年 8en7am1n. All rights reserved.
//

import Foundation

class WallPost: PFObject, PFSubclassing {
    @NSManaged var image: PFFile
    @NSManaged var user: PFUser
    @NSManaged var comment: String?
    @NSManaged var numOfButton : Double
    @NSManaged var greenX : Double
    @NSManaged var greenY : Double
    @NSManaged var redX : Double
    @NSManaged var redY : Double
    @NSManaged var yellowX : Double
    @NSManaged var yellowY : Double
    @NSManaged var blueX : Double
    @NSManaged var blueY : Double
    @NSManaged var endAt: NSDate
    
    //按照後台資料庫的記錄設置類名。
    class func parseClassName() -> String {
        return "WallPost"
    }
    
    //讓Parse知道：所有類的類型為WallPost的對象，都將使用該子類。這個方法只應被調用一次，因此我們使用dispatch_once_t方法。
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: WallPost.parseClassName()) //為WallPost類創建PFQuery對象。
        query.includeKey("user") //調用該方法以返回完整的user信息。若沒有這句，該query只會返回當前對象的引用，而不包含任何成員的信息。
        query.orderByDescending("createdAt") //按照創建日期排序。
        return query
    }
    
    //最後，我們需要添加初始化方法。
    init(image: PFFile, user: PFUser, comment: String?, numOfButton: Double, greenX: Double, greenY: Double, redX: Double, redY: Double, yellowX: Double, yellowY: Double, blueX: Double, blueY: Double, endAt: NSDate) {
        super.init()
        
        self.image = image
        self.user = user
        self.comment = comment
        self.numOfButton = numOfButton
        self.greenX = greenX
        self.greenY = greenY
        self.redX = redX
        self.redY = redY
        self.yellowX = yellowX
        self.yellowY = yellowY
        self.blueX = blueX
        self.blueY = blueY
        self.endAt = endAt
    }
    
    override init() {
        super.init()
    }
    
    
}