//
//  SaveImage.swift
//  camera_droplet
//
//  Created by Kimberly Sookoo on 1/30/16.
//  Copyright © 2016 Woof Warrior. All rights reserved.
//

import UIKit

class SaveImage: NSObject, NSCoding {
    
    var photo: UIImage?
    
    var completed: Bool {
        get {
            return photo != nil
        }
    }
    
    let photoKey = "photo"
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let thePhoto = photo {
            aCoder.encodeObject(thePhoto, forKey: photoKey)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
    }
    
    init(photo: UIImage) {
        self.photo = photo
    }
}
