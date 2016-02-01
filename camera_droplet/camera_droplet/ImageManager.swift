//
//  ImageManager.swift
//  camera_droplet
//
//  Created by Kimberly Sookoo on 1/30/16.
//  Copyright © 2016 Woof Warrior. All rights reserved.
//

import UIKit

class ImageManager {
    var savedImage: SaveImage?
    
    func archivePath() -> String? {
        let directoryList = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        if let documentsPath = directoryList.first {
            return documentsPath + "/SavedImage"
        }
        
        assertionFailure("Could not determine where to store files")
        return nil
    }
    
    func save() {
        if let theArchivePath = archivePath() {
            if NSKeyedArchiver.archiveRootObject(savedImage!, toFile: theArchivePath) {
                print("Saved successfully!")
            } else {
                assertionFailure("Could not save data to \(theArchivePath)")
            }
        }
    }
    
    func unarchiveSavedItems() {
        if let theArchivePath = archivePath() {
            if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath) {
                savedImage = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as? SaveImage
            }
        }
    }
    
    init() {
        unarchiveSavedItems()
    }
}
