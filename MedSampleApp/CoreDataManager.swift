//
//  CoreDataManager.swift
//  MedSampleApp
//
//  Created by Mariano Bessone on 8/13/17.
//  Copyright © 2017 Mariano Bessone. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {

    // Unique CoreDataManager (singleton).
    static let instance = CoreDataManager()
    // Constants.
    private static let WeightModelId = "WeightModel"
    private static let WeightRecordId = "WeightRecord"
    private static let EntityWeightValueId = "weight"
    private static let EntityDateValueId = "date"

    // Persistent container.
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataManager.WeightModelId)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()

    // Returns the managed object context, needed to save and restore data.
    private func getContext () -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // Persists a new WeightRecord.
    func storeWeightRecord(record: WeightRecord) {
        let context = self.getContext()
        // Retrieve WeightRecord entity for our model.
        let entity =  NSEntityDescription.entity(forEntityName: CoreDataManager.WeightRecordId, in: context)
        let managed = NSManagedObject(entity: entity!, insertInto: context)
        //set the entity values
        managed.setValue(record.date, forKey: CoreDataManager.EntityDateValueId)
        managed.setValue(record.weight, forKey: CoreDataManager.EntityWeightValueId)

        // Saves the input record.
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }

    // Get all the WeightRecord's persisted.
    func getWeightRecords () -> [WeightRecord] {
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataManager.WeightRecordId)
        do {
            // Fetchs all NSManagedObject elements.
            let mol = try context.fetch(fetchRequest)
            // Converts NSManagedObject's to WeightRecord's.
            let wrl = mol.map({d in WeightRecord(date: d.value(forKey: CoreDataManager.EntityDateValueId) as! Date,
                                                 weight: d.value(forKey: CoreDataManager.EntityWeightValueId) as! Double)})
            return wrl
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }

}
