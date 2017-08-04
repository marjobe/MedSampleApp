//
//  DataManager.swift
//  MedSampleApp
//
//  Created by Mariano Bessone on 8/1/17.
//  Copyright © 2017 Mariano Bessone. All rights reserved.
//

import Foundation

final class DataManager {

    // Unique DataManager (singleton).
    static let instance = DataManager()
    // Constants for data persistence.
    private let healthDataKey = "SavedHealthData"
    private let defaults = UserDefaults.standard

    // Historic values: min, max and last values.
    private var historic: [WeightRecord]

    private init() {
        // Try to get historic values from persistent data.
        if let healthDataObject = defaults.value(forKey: healthDataKey) as? NSData {
            self.historic = NSKeyedUnarchiver.unarchiveObject(with: healthDataObject as Data) as! [WeightRecord]
        } else {
            // No previous persistent data, set default values.
            self.historic = []
        }
    }

    func insertNewRecord(date: Date, weight: Double) {
        historic.append(WeightRecord(date: date, weight: weight))
    }

    func historicRecords() -> [WeightRecord] {
        return historic
    }

    func saveHealthData() {
        // Persist data using 'UserDefaults' module.
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: historic), forKey: healthDataKey)
    }
}
