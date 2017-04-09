//
//  UINavigationController.swift
//  VoteSelect
//
//  Created by BEN on 20/1/2016.
//  Copyright © 2016年 8en7am1n. All rights reserved.
//

import UIKit

class NavigationController : UINavigationController{
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoImage = UIImageView(frame: CGRect(x:0, y:0, width: 150, height: 30))
        logoImage.contentMode = .ScaleAspectFit
        
        let logo = UIImage(named: "voteLogo.png")
        logoImage.image = logo
        
        self.navBar.topItem?.titleView = logoImage
    }
}
