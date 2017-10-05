//
//  Meal.swift
//  FoodTracker
//
//  Created by Tommy on 9/18/17.
//  Copyright © 2017 Tommy. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    //    MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //    MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //    MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //    MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        //        Initialization should fail if there is no name or if the rating is nagative
        guard !name.isEmpty else {
            return nil
        }
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        //        Initalize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    //    MARK: NSCoding
    func encode(with aCoder: NSCoder)  {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("unable to decode the name for a Meal obj", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        //        must call desingated initializer.
        self.init(name: name, photo: photo, rating: rating)
    }
    
}
