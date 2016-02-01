//
//  ColorImage.swift
//  camera_droplet
//
//  Created by Kimberly Sookoo on 1/30/16.
//  Copyright © 2016 Woof Warrior. All rights reserved.
//

import UIKit

class ColorImage: NSObject, NSCoding {
    
    //let name: String
    var color: UIColor?
    
    var completed: Bool {
        get {
            return color != nil
        }
    }
    
    //let nameKey = "name"
    let colorKey = "color"
    //let photoKey = "photo"
    
    func encodeWithCoder(aCoder: NSCoder) {
        //aCoder.encodeObject(name, forKey: nameKey)
        if let theColor = color {
            aCoder.encodeObject(theColor, forKey: colorKey)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        //name = aDecoder.decodeObjectForKey(nameKey) as! String
        color = aDecoder.decodeObjectForKey(colorKey) as? UIColor
        //photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
    }
    
    init(color: UIColor) {
        //self.name = name
        self.color = color
    }
}
