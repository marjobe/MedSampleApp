//
//  WeightRecord.swift
//  MedSampleApp
//
//  Created by Mariano Bessone on 8/1/17.
//  Copyright © 2017 Mariano Bessone. All rights reserved.
//

import Foundation
import CoreData

class WeightRecord {

    // Data. Note: weight is always stored in Kg.
    var date : Date!
    var weight : Double!

    // Default constructor.
    init(date: Date, weight: Double) {
        self.date = date
        self.weight = weight
    }

}
