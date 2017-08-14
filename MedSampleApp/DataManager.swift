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
    private let coreDataManager = CoreDataManager.instance
    private let defaults = UserDefaults.standard
    private let weightUnitKey = "SavedWeightUnitData"
    // Historic values: min, max and last values.
    private var historic: [WeightRecord]
    private var weightUnitData: WeightUnitData

    // Default constructor.
    private init() {
        // Try to get historic values from persistent data.
        if let weightUnitData = defaults.value(forKey: weightUnitKey) as? NSData {
            self.weightUnitData = NSKeyedUnarchiver.unarchiveObject(with: weightUnitData as Data) as! WeightUnitData
        } else {
            // No previous persistent data, set default values.
            self.weightUnitData = WeightUnitData()
        }
        // Restores all the WeightRecord's saved.
        historic = coreDataManager.getWeightRecords()
    }


    /* Records management section. */

    func insertNewRecord(date: Date, weight: Double) {
        let wr = WeightRecord(date: date,
                              weight: WeightUnitData.convertToKg(value: weight, from: weightUnitData.getCurrentUnit()))
        // Adds it to the current list.
        historic.append(wr)
        // Persists the new entry in CoreData model.
        coreDataManager.storeWeightRecord(record: wr)
    }

    func historicRecords() -> [WeightRecord] {
        return historic
    }


    /* Weight section. */

    public static func getWeightUnits() -> [String] {
        return WeightUnitData.getAllUnits()
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


    /* Persistence section. */

    func saveSettings() {
        // Saves settings data.
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: weightUnitData), forKey: weightUnitKey)
    }

}
