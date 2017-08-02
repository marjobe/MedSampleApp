//
//  WeightRecord.swift
//  MedSampleApp
//
//  Created by Mariano Bessone on 8/1/17.
//  Copyright © 2017 Mariano Bessone. All rights reserved.
//

import Foundation

class WeightRecord {
    // Data
    var date : Date
    var weight : Double

    init(date: Date, weight: Double) {
        self.date = date
        self.weight = weight
    }

}
