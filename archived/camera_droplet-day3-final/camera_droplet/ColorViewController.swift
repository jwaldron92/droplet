//
//  ColorViewController.swift
//  camera_droplet
//
//  Created by Kimberly Sookoo on 1/30/16.
//  Copyright © 2016 Woof Warrior. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    

    
    @IBOutlet weak var colorButton: UIButton!
    
    let cM = ColorsManager()
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        colorButton.backgroundColor = cM.savedColor?.color
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
