//
//  InputViewController.swift
//  MedSampleApp
//
//  Created by Mariano Bessone on 7/31/17.
//  Copyright © 2017 Mariano Bessone. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    // Controller: DataManager
    let dataManager = DataManager.instance

    // UI outlets.
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var weightUnit: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set current date to show.
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let result = formatter.string(from: date)
        self.date.text = result
        // Set default weight to show.
        weight.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Reload data every time that the view is visited.
        weight.text = "0"
        weightUnit.text = dataManager.getWeightUnitData().getCurrentUnit().shortName
    }
    
    @IBAction func saveWeight(_ sender: UIButton) {
        // Gets the double number from user text input and insert it on the model.
        if let text = weight.text {
            let doubleValue = Double(text)!
            dataManager.insertNewRecord(date: Date(), weight: doubleValue)
        }
        // Hide keyboard
        weight.resignFirstResponder()
        // Clear weight.
        weight.text = "0"
    }

}

