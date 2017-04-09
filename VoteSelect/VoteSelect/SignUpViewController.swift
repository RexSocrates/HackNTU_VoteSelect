//
//  SignUpViewController.swift
//  VoteSelect
//
//  Created by BEN on 18/12/2015.
//  Copyright © 2015年 8en7am1n. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userImageButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var TextPasswordAgain: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    override func viewDidLoad() {
        //        self.addEddect()
        
        //圓角
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        self.profileImageView.layer.masksToBounds = true
        
        
        profileImageView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).CGColor
        profileImageView.layer.borderWidth = 5
        
        self.addTextBottomLine()
        self.addTextPassword()
        self.addTextPasswordAgain()
        self.addTextEmail()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)//Calls this function when the tap is recognized.
        
        initializeTextFields()//呼叫方法
        
    }
    
    func initializeTextFields(){
        //限制鍵盤
        textUserName.delegate = self
        textUserName.keyboardType = UIKeyboardType.ASCIICapable
        textPassword.delegate = self
        textPassword.keyboardType = UIKeyboardType.ASCIICapable
        TextPasswordAgain.delegate = self
        TextPasswordAgain.keyboardType = UIKeyboardType.ASCIICapable
        textEmail.delegate = self
        textEmail.keyboardType = UIKeyboardType.EmailAddress
        //清除按鈕
        textUserName.clearButtonMode=UITextFieldViewMode.WhileEditing
        textPassword.clearButtonMode=UITextFieldViewMode.WhileEditing
        TextPasswordAgain.clearButtonMode=UITextFieldViewMode.WhileEditing
        textEmail.clearButtonMode=UITextFieldViewMode.WhileEditing
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
        
        let profileImage = self.profileImageView.image
        let username = self.textUserName.text
        let password = self.textPassword.text
        let password2 = self.TextPasswordAgain.text
        let email = self.textEmail.text
        let finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // 驗證文字欄位
        if let username = username where username.characters.count < 5 {
            let alert = UIAlertView(title: "無效", message: "用戶名稱至少使用5個字元", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if let password = password where password.characters.count < 8 {
            let alert = UIAlertView(title: "無效", message: "密碼至少8個字元", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if textPassword.text != TextPasswordAgain.text {
            let alert = UIAlertView(title: "無效", message: "你的密碼不相符", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if let email = email where email.characters.count < 8 {
            let alert = UIAlertView(title: "無效", message: "請輸入正確的電子郵件", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            // 顯示旋轉圖示，代表工作正在進行中
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = finalEmail

            let profileImageData = UIImageJPEGRepresentation(profileImageView.image!, 1)
            
            if(profileImageData != nil){
                let profileImageFile = PFFile(data: profileImageData!)
                newUser.setObject(profileImageFile!, forKey: "profileImage")
            }
            
            // 以非同步方式註冊使用者
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // 停止旋轉圖示
                spinner.stopAnimating()
                if ((error) != nil) {
                    let alert = UIAlertView(title: "失敗", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                } else {
                    let alert = UIAlertView(title: "成功", message: "註冊成功", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TabBar")
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
            })
        }
    }
    
    func dismissKeyboard() { //鍵盤消失
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func addTextBottomLine(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.whiteColor().CGColor
        border.frame = CGRect(x: 0, y: textUserName.frame.size.height - width + 1, width:  textUserName.frame.size.width, height: textUserName.frame.size.height)
        
        border.borderWidth = width
        textUserName.layer.addSublayer(border)
        textUserName.layer.masksToBounds = true
        //加底線
    }
    
    func addTextPassword(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.whiteColor().CGColor
        border.frame = CGRect(x: 0, y: textPassword.frame.size.height - width + 1, width:  textPassword.frame.size.width, height: textPassword.frame.size.height)
        
        border.borderWidth = width
        textPassword.layer.addSublayer(border)
        textPassword.layer.masksToBounds = true
        //加底線
    }
    
    func addTextPasswordAgain(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.whiteColor().CGColor
        border.frame = CGRect(x: 0, y: TextPasswordAgain.frame.size.height - width + 1, width:  TextPasswordAgain.frame.size.width, height: TextPasswordAgain.frame.size.height)
        
        border.borderWidth = width
        TextPasswordAgain.layer.addSublayer(border)
        TextPasswordAgain.layer.masksToBounds = true
        //加底線
    }
    
    func addTextEmail(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.whiteColor().CGColor
        border.frame = CGRect(x: 0, y: textEmail.frame.size.height - width + 1, width:  textEmail.frame.size.width, height: textEmail.frame.size.height)
        
        border.borderWidth = width
        textEmail.layer.addSublayer(border)
        textEmail.layer.masksToBounds = true
        //加底線
    }
    
    @IBAction func userImageButton(sender: AnyObject) {
        
        //Open a UIImagePickerController to select the picture
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        profileImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textEmail.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        ScrollView.setContentOffset(CGPointMake(0, 120), animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        ScrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    
    //    func addEddect(){
    //        var effect = UIBlurEffect(style: .Light)
    //
    //        var effectView = UIVisualEffectView(effect: effect)
    //
    //        effectView.frame = CGRectMake(0, 0, 320, 400)
    //
    //        view.addSubview(effectView)
    //    }
    //    模糊
    
    
}