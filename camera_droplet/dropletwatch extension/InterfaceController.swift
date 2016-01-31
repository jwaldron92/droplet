//
//  InterfaceController.swift
//  dropletWatch Extension
//
//  Created by JJW on 1/30/16.
//  Copyright © 2016 Woof Warrior. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var colorMatch: WKInterfaceLabel!
    
    override init(){
        super.init()
        print("In the init initializer")
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        print("In the awake with context event")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
       // let color1 =
        //colorMatch.setTextColor(color: UIColor?)
        super.willActivate()
        print("In the willactivate context")
    }
    
    
//anytime receives information from phone
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        print("In the didDeactivate event")
    }
    

}
