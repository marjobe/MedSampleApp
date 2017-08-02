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

    // Historic values: min, max and last values.
    private var historic: [WeightRecord]

    private init() {
        // ToDo: save and restore historic from UserDefaults
        historic = []
    }

    func insertNewRecord(date: Date, weight: Double) {
        historic.append(WeightRecord(date: date, weight: weight))
    }

    func historicRecords() -> [WeightRecord] {
        return historic
    }
}
