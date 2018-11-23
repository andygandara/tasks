//
//  CategoryModel.swift
//  tasks
//
//  Created by Andy Gandara on 11/22/18.
//  Copyright © 2018 Andy Gandara. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CategoryModel {
    
    func fetchRecords() -> [CategoryEntity] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryEntity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "title") as! String)
            }
            return result as! [CategoryEntity]
            
        } catch {
            print("Failed to fetch category records.")
            return []
        }
    }
    
    func add(title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CategoryEntity", in: context)
        
        let newCategory = NSManagedObject(entity: entity!, insertInto: context)
        newCategory.setValue(title, forKey: "title")
        
        do {
            try context.save()
            print("New category saved successfully.")
        } catch {
            print("Failed to save category.")
        }
    }
    
}
