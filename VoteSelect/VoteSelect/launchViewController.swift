//
//  ViewController.swift
//  VoteSelect
//
//  Created by BEN on 11/12/2015.
//  Copyright © 2015年 8en7am1n. All rights reserved.
//

import UIKit
import Parse

class launchViewController: UIViewController {
    

    @IBOutlet weak var startButton: UIButton!


    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
        //為了能夠關閉註冊畫面，我們需要定義用來解除的 Segue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

//    override func viewDidLayoutSubviews(){
//        
//        let viewWidth = self.view.bounds.width
//        let viewHeight = self.view.bounds.height
//        let buttonWidth = viewWidth / 2
//        
//        self.loginButton.bounds.size = CGSize(width: buttonWidth, height: 44)
//        self.loginButton.center = CGPoint(x: viewWidth - 0.5 * buttonWidth, y: viewHeight - 22)
//        
//        self.signupBotton.bounds.size = CGSize(width: buttonWidth, height: 44)
//        self.signupBotton.center = CGPoint(x: 0.5 * buttonWidth, y: viewHeight - 22)
//        
//        
//    }
    
    @IBAction func startButton(sender: AnyObject) {
    }

    


    
}

