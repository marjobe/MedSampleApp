//
//  HistoricViewController.swift
//  MedSampleApp
//
//  Created by Mariano Bessone on 8/2/17.
//  Copyright © 2017 Mariano Bessone. All rights reserved.
//

import UIKit

class HistoricViewController: UITableViewController {

    // Controller: DataManager
    let dataManager = DataManager.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Reload data every time that the table is visited.
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // There is only one section.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // The number of elements depends on the data manager components.
        return dataManager.historicRecords().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "WeightTableViewCell"
        
        // Fetches the appropriate item from the model to show it.
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WeightTableViewCell {
            // Get the i-th historic record.
            let weightData = dataManager.historicRecords()[indexPath.row]
            // Fill date
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd hh:mm"
            cell.date.text = formatter.string(from: weightData.date)
            // Fill weight
            let weightValue = dataManager.getWeightForCurrUnit(valueInKg: weightData.weight)
            cell.weight.text = String(round(weightValue*100)/100)
            // Fill weight unit rounded in 2 decimals.
            cell.weightUnit.text = dataManager.getWeightUnitName()

            // Return filled cell.
            return cell
        } else {
            // Return default cell.
            return UITableViewCell()
        }
    }


}

