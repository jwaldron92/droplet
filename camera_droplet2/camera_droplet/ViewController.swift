//
//  ViewController.swift
//  camera_droplet
//
//  Created by JJW on 1/29/16.
//  Copyright © 2016 Woof Warrior. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a);
        
    }
}

    extension UIColor{
        func rgb() -> Int? {
            var fRed : CGFloat = 0
            var fGreen : CGFloat = 0
            var fBlue : CGFloat = 0
            var fAlpha: CGFloat = 0
            if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
                let iRed = Int(fRed * 255.0)
                let iGreen = Int(fGreen * 255.0)
                let iBlue = Int(fBlue * 255.0)
                let iAlpha = Int(fAlpha * 255.0)
                
                //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
                let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
                return rgb
            } else {
                // Could not extract RGBA components:
                return 4
        }
        }
        var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
            var r:CGFloat = 0
            var g:CGFloat = 0
            var b:CGFloat = 0
            var a:CGFloat = 0
            if getRed(&r, green: &g, blue: &b, alpha: &a) {
                return (r,g,b,a)
            }
            return (0,0,0,0)
        }
        // hue, saturation, brightness and alpha components from UIColor**
        var hsbComponents:(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
            var hue:CGFloat = 0
            var saturation:CGFloat = 0
            var brightness:CGFloat = 0
            var alpha:CGFloat = 0
            if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha){
                return (hue,saturation,brightness,alpha)
            }
            return (0,0,0,0)
        }
        var htmlRGBColor:String {
            return String(format: "#%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255))
        }
        var htmlRGBaColor:String {
            return String(format: "#%02x%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255),Int(rgbComponents.alpha * 255) )
        }
    }

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var imagePicker = UIImagePickerController()
    
    var colorPickerViewController: UIViewController!

    
    @IBOutlet weak var imageViewOutlet: UIView!
    
    @IBOutlet weak var imageTemp: UIImageView!
    
    @IBOutlet weak var pickerImage: UIImageView!
    @IBOutlet weak var capture: UIButton!
    
    @IBOutlet weak var colorText2: UILabel!
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
        
//        imageTemp.image = image
        pickerImage.image = resizeImage(image, newHeight: CGFloat(300))
       // pickerImage.image = image
        
        
    }
    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage {
        
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    @IBOutlet weak var colorText: UITextField!
    
    @IBAction func setrgb(sender: AnyObject) {
        
        //Make sure only 1x image is set
        let image : UIImage = imageTemp.image!;
        //Make sure point is within the image
        let color = image.getPixelColor(CGPointMake(CGFloat(xval.value), CGFloat(yval.value)))
        colorText.backgroundColor = color;
        let myRedHueWebColor = String(color.htmlRGBColor);
        colorText2.text = myRedHueWebColor;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.imageViewOutlet.addGestureRecognizer(gestureRecognizer)
        
        
        if let colorPickerViewController = self.colorPickerViewController as? ColorPickerViewController {
            colorText2.text = colorPickerViewController.label
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        print("You tapped at \(gestureRecognizer.locationInView(self.view))")
        print("You tapped at \(gestureRecognizer.locationInView(view))")
        print(pickerImage.image!.size.height)
        print(pickerImage.image!.size.width)
        //imageViewOutlet.frame = CGRectMake(0 , 0, pickerImage.image!.size.width, pickerImage.image!.size.height)
        let point = gestureRecognizer.locationInView(self.view)
        let xPoint = (point.x * 0.91777)
        let yPoint = point.y
        let image : UIImage = pickerImage.image!;
        let color = image.getPixelColor(CGPointMake(xPoint, yPoint))
        colorText.backgroundColor = color;
        colorText2.text = color.htmlRGBColor
    }
    
    func changeColorText2(text: String) {
        if let colorText2 = self.colorText2 {
            colorText2.text = text
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toColorPicker" {
            self.colorPickerViewController = segue.destinationViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

