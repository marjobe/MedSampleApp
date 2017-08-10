//
//  SettingsViewController.swift
//  MedSampleApp
//
//  Created by Mariano Bessone on 8/6/17.
//  Copyright © 2017 Mariano Bessone. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // Controller: DataManager
    let dataManager = DataManager.instance
    var weightUnitPickerData = WeightUnitData.getAllUnits()
    // UI outlets.
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var weightUnitTitle: UILabel!
    @IBOutlet weak var weightUnitPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.weightUnitPicker.delegate = self
        self.weightUnitPicker.dataSource = self
        weightUnitPicker.selectRow(dataManager.getWeightUnitRow(), inComponent: 0, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // DataSource
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.weightUnitPickerData.count
    }

    // Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weightUnitPickerData[row]
    }

    // Delegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dataManager.setWeightUnit(byRow: row)
    }

}

