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
    
    let myManager = ColorsManager()
    let imageManager = ImageManager()
    
    @IBAction func takePhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            
        } else {
            
            let alert = UIAlertController(title: "", message: "No camera available", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
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
        
        let imageS = SaveImage(photo: image)
        imageManager.savedImage = imageS
        imageManager.save()
        
        imageTemp.image = image
        
    }
    
    @IBOutlet weak var colorText: UITextField!
    
    @IBAction func setrgb(sender: AnyObject) {
        
        //Make sure only 1x image is set
        let image : UIImage = imageTemp.image!;
        //Make sure point is within the image
        let color = image.getPixelColor(CGPointMake(CGFloat(xval.value), CGFloat(yval.value)))
        colorText.backgroundColor = color;
        
        let colorImage = ColorImage(color: color)
        
        myManager.savedColor = colorImage
        myManager.save()
        
    }
    
    
    @IBAction func showColor(sender: AnyObject) {
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

