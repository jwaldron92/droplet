//
//  ViewController.swift
//  camera_droplet
//
//  Created by JJW on 1/29/16.
//  Copyright © 2016 Woof Warrior. All rights reserved.
//


import UIKit
extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var imagePicker = UIImagePickerController()

    @IBOutlet weak var imageTemp: UIImageView!
    
    @IBOutlet weak var capture: UIButton!
    
    @IBOutlet weak var setColor: UIButton!
    @IBOutlet weak var xval: UISlider!
    @IBOutlet weak var yval: UISlider!
    @IBOutlet weak var camera: UIButton!
    @IBAction func btnClicked(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            print("Button capture")
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        imageTemp.image = image
        
    }
    
    @IBOutlet weak var colorText: UITextField!
    
    @IBAction func setrgb(sender: AnyObject) {
        
        //Make sure only 1x image is set
        let image : UIImage = imageTemp.image!;
        //Make sure point is within the image
        let color = image.getPixelColor(CGPointMake(CGFloat(xval.value), CGFloat(yval.value)))
        colorText.backgroundColor = color;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

