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
    private let defaults = UserDefaults.standard
    private let healthDataKey = "SavedHealthData"
    private let weightUnitKey = "SavedWeightUnitData"

    // Historic values: min, max and last values.
    private var historic: [WeightRecord]
    private var weightUnitData: WeightUnitData

    private init() {
        // Try to get historic values from persistent data.
        if let healthDataObject = defaults.value(forKey: healthDataKey) as? NSData,
           let weightUnitData = defaults.value(forKey: weightUnitKey) as? NSData {
            self.historic = NSKeyedUnarchiver.unarchiveObject(with: healthDataObject as Data) as! [WeightRecord]
            self.weightUnitData = NSKeyedUnarchiver.unarchiveObject(with: weightUnitData as Data) as! WeightUnitData
        } else {
            // No previous persistent data, set default values.
            self.historic = []
            self.weightUnitData = WeightUnitData()
        }
    }

    func insertNewRecord(date: Date, weight: Double) {
        historic.append(WeightRecord(date: date,
            weight: WeightUnitData.convertToKg(value: weight, from: weightUnitData.getCurrentUnit())))
    }

    func historicRecords() -> [WeightRecord] {
        return historic
    }

    func getWeightUnitName() -> String {
        return weightUnitData.getCurrentUnit().shortName
    }

    func getWeightUnitRow() -> Int {
        return weightUnitData.getCurrentUnitRow()
    }

    func setWeightUnit(byRow: Int) {
        weightUnitData.changeCurrentUnit(unitIndex: byRow)
    }

    func getWeightForCurrUnit(valueInKg: Double) -> Double {
        return WeightUnitData.convertFromKg(valueInKg: valueInKg, to: weightUnitData.getCurrentUnit())
    }

    func saveHealthData() {
        // Persist data using 'UserDefaults' module.
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: historic), forKey: healthDataKey)
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: weightUnitData), forKey: weightUnitKey)
    }
}
