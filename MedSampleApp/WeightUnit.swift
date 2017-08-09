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

    // Constants.
    static private let Kg = WeightUnit(name: "Kilograms", shortName: "Kg", rateConversionFromKg: 1)
    static private let Lb = WeightUnit(name: "Pounds", shortName: "Lbs", rateConversionFromKg: 2.20462)
    static private let Units = [Kg, Lb]
    static private let UnitShortNames = WeightUnitData.Units.map({wu in wu.shortName})

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

    // Actual weight unit value
    private var value : Int!

    // Default constructor.
    init(unitIndex: Int = WeightUnitData.UnitShortNames.index(of: "Kg")!) {
        self.value = unitIndex
    }

    // Constructor for decoder.
    required init?(coder aDecoder: NSCoder){
        self.value = aDecoder.decodeObject(forKey: "unit") as! Int
    }

    // Function used to encode data.
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.value, forKey: "unit")
    }

    // Change current unit given a unit name that exists in getAllUnits() array.
    func changeCurrentUnit(unitName: String) {
        if let index = WeightUnitData.UnitShortNames.index(of: unitName) {
            changeCurrentUnit(unitIndex: index)
        }
    }

    // Change current unit given a index of getAllUnits() array.
    func changeCurrentUnit(unitIndex: Int) {
        if unitIndex >= 0 &&
            unitIndex < WeightUnitData.Units.count &&
            unitIndex != self.value {
            self.value = unitIndex
        }
    }

    // Returns the actual weight unit.
    func getCurrentUnit() -> WeightUnit {
        return WeightUnitData.Units[value]
    }

    // Returns the actual weight unit.
    func getCurrentUnit() -> Int {
        return value
    }

}