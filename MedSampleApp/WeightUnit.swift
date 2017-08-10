//
//  WeightUnit.swift
//  MedSampleApp
//
//  Created by Mariano Bessone on 8/7/17.
//  Copyright © 2017 Mariano Bessone. All rights reserved.
//

import Foundation

class WeightUnit {
    // Data
    var name : String
    var shortName : String
    var rateConversionFromKg : Double

    // Constructor.
    init(name: String, shortName: String, rateConversionFromKg: Double) {
        self.name = name
        self.shortName = shortName
        self.rateConversionFromKg = rateConversionFromKg
    }
}

class WeightUnitData: NSObject, NSCoding {

    // Constants for Kg and Lb weight units.
    static private let Kg = WeightUnit(name: "Kilograms", shortName: "Kg", rateConversionFromKg: 1)
    static private let Lb = WeightUnit(name: "Pounds", shortName: "Lbs", rateConversionFromKg: 2.20462)
    // Units: collection of all weight units.
    static private let Units = [Kg, Lb]
    // UnitShortNames: collection of all weight unit names.
    static private let UnitShortNames = WeightUnitData.Units.map({wu in wu.shortName})

    // Current weight unit indicated by row in 'Units' collection.
    private var rowValue : Int!

    // Returns all weight units.
    static func getAllUnits() -> [String] {
        return UnitShortNames
    }

    // Converts a weight from a given weight unit to Kg.
    static func convertToKg(value: Double, from: WeightUnit) -> Double {
        return value/from.rateConversionFromKg
    }

    // Converts a weight in Kg to a given weight unit.
    static func convertFromKg(valueInKg: Double, to: WeightUnit) -> Double {
        return valueInKg * to.rateConversionFromKg
    }

    // Default constructor.
    init(unitIndex: Int = 0) {
        self.rowValue = unitIndex
    }

    // Constructor for decoder.
    required init?(coder aDecoder: NSCoder){
        self.rowValue = aDecoder.decodeObject(forKey: "unit") as! Int
    }

    // Function used to encode data.
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.rowValue, forKey: "unit")
    }

    // Change current unit given a index of getAllUnits() array.
    public func changeCurrentUnit(unitIndex: Int) {
        if unitIndex >= 0 &&
            unitIndex < WeightUnitData.Units.count &&
            unitIndex != self.rowValue {
            self.rowValue = unitIndex
        }
    }

    // Returns the actual weight unit.
    public func getCurrentUnit() -> WeightUnit {
        return WeightUnitData.Units[self.rowValue]
    }

    // Returns the actual weight unit.
    public func getCurrentUnitRow() -> Int {
        return self.rowValue
    }

}
