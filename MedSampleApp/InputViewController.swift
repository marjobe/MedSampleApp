//
//  InputViewController.swift
//  MedSampleApp
//
//  Created by Mariano Bessone on 7/31/17.
//  Copyright © 2017 Mariano Bessone. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    // Mark: properties
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
        // ToDo: get the unit from settings.
        weightUnit.text = "kg"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveWeight(_ sender: UIButton) {
        // ToDo
        
        // Hide keyboard
        weight.resignFirstResponder()
    }

}

