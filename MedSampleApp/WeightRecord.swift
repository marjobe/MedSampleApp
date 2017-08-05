//
//  WeightRecord.swift
//  MedSampleApp
//
//  Created by Mariano Bessone on 8/1/17.
//  Copyright © 2017 Mariano Bessone. All rights reserved.
//

import Foundation

class WeightRecord: NSObject, NSCoding {

    // Data
    var date : Date!
    var weight : Double!

    // Default constructor.
    init(date: Date, weight: Double) {
        self.date = date
        self.weight = weight
    }

    // Constructor for decoder.
    required init?(coder aDecoder: NSCoder){
        self.date = aDecoder.decodeObject(forKey: "date") as! Date
        self.weight = aDecoder.decodeObject(forKey: "weight") as! Double
    }

    // Function used to encode data.
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(weight, forKey: "weight")
    }
}
