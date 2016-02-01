//
//  ColorPickerViewController.swift
//  camera_droplet
//
//  Created by JJW on 1/30/16.
//  Copyright © 2016 Woof Warrior. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var label: String?
    var touched: Bool?
    
    var vc = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        touched = false
        //label = "TESTTESTTESTTEST"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touched")

        var touch = touches.first
        let location = touch!.locationInView(self.view)
        print(location)
        
        //do stuff
        if let touched = self.touched {
            if touched {
                vc.changeColorText2("DERP")
            } else {
                vc.changeColorText2("STOP")
            }
            self.touched = !touched
        }

        
    }
    
    func returnLabel()->String {
        return "text"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
