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
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var weightUnit: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set a timer to update the date and time text labels.
        Timer.scheduledTimer(timeInterval: 60,
                             target: self,
                             selector: #selector(self.updateTime),
                             userInfo: nil,
                             repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Set date and time to show.
        updateTime()
        // Set default weight to show.
        weight.text = "0"
        // Set current weight unit.
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

    func updateTime() {
        let date = Date()
        // Set current date to show.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.date.text = formatter.string(from: date)
        // Set current time to show.
        formatter.dateFormat = "hh:mm"
        self.time.text = formatter.string(from: date)
    }

}

