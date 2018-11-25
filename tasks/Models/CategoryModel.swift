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
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchRecords() -> [CategoryEntity] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryEntity")
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
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
        if !categoryExists(title: title) {
            let entity = NSEntityDescription.entity(forEntityName: "CategoryEntity", in: context)
            
            let newCategory = NSManagedObject(entity: entity!, insertInto: context)
            newCategory.setValue(title, forKey: "title")
            
            do {
                try context.save()
                print("New category saved successfully.")
            } catch {
                print("Failed to save category.")
            }
        } else {
            print("Category already exists.")
        }
    }
    
    func delete(at: Int) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryEntity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let objectToDelete = result[at] as! NSManagedObject
            print("Deleting: \(objectToDelete)")
            context.delete(objectToDelete)
            
        } catch {
            print("Failed to delete category.")
        }
    }
    
    func categoryExists(title: String) -> Bool {
        let records = fetchRecords()
        for record in records where record.title == title {
            return true
        }
        return false
    }
    
}
