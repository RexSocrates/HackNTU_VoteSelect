//
//  ImagePickerViewController.swift
//  VoteSelect
//
//  Created by Socrates Hung on 2016/1/19.
//  Copyright © 2016年 8en7am1n. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePicked: UIImageView!
    var imageIsFromCamera : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicked.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func openCamera(sender: AnyObject) {
        print("Camera is opened")
        
        self.imageIsFromCamera = true
        //Check if the Camera is available on the device
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func openPhotoLibrary(sender: AnyObject) {
        print("Library is opened")
        self.imageIsFromCamera = false
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        self.saveImageToAlbum()
    }
    
    
    //有需要再呼叫()
    func saveImageToAlbum() {
        var imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.8)
        var conpressedJEPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(conpressedJEPGImage!, nil, nil, nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if self.imageIsFromCamera {
            self.saveImageToAlbum()
        }
        
        if segue.identifier == "imagePickerToButtonSetting" {
            var nextController = segue.destinationViewController as? SettingButtonViewController
            nextController!.receivedImage = imagePicked
            
        }
    }
    
}
