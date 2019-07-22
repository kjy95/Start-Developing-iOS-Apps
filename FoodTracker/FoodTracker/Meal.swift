//
//  Meal.swift
//  FoodTracker
//
//  Created by Vimosoft on 02/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit
import os.log
struct ProportyKey{
    static let nameKey = "name"
    static let photoKey = "photoKey"
    static let ratingKey = "ratingKey"
    
}
class Meal : NSObject, NSCoding{
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        // Initialization should fail if there is no name or if the rating is negative.
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
    }
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: ProportyKey.nameKey)
        aCoder.encode(photo, forKey: ProportyKey.photoKey)
        aCoder.encode(rating, forKey: ProportyKey.ratingKey)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: ProportyKey.nameKey) as? String else{
            os_log("Unable to decode the name for a Meal object", log: OSLog.default, type: .debug)
            return nil
        }
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: ProportyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: ProportyKey.ratingKey)
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
    }
}
