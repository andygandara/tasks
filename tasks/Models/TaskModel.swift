//
//  TaskModel.swift
//  tasks
//
//  Created by Andy Gandara on 11/22/18.
//  Copyright © 2018 Andy Gandara. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TaskModel {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchRecords() -> [TaskEntity] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "title") as! String)
                print(data.value(forKey: "category") as! String)
                print(data.value(forKey: "date") as! Date, "\n")
                print(data.value(forKey: "completed") ?? "", "\n")
            }
            return result as! [TaskEntity]
            
        } catch {
            print("Failed to fetch task records.")
            return []
        }
    }
    
    func add(title: String, category: String, date: Date) {
        let entity = NSEntityDescription.entity(forEntityName: "TaskEntity", in: context)
        
        let newTask = NSManagedObject(entity: entity!, insertInto: context)
        newTask.setValue(title, forKey: "title")
        newTask.setValue(category, forKey: "category")
        newTask.setValue(date, forKey: "date")
        
        do {
            try context.save()
            print("New category saved successfully.")
        } catch {
            print("Failed to save category.")
        }
    }
    
    func delete(at: Int) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let objectToDelete = result[at] as! TaskEntity
            print("Deleting: \(objectToDelete)")
            context.delete(objectToDelete)
            
        } catch {
            print("Failed to delete task.")
        }
        
    }
    
    func completeTask(at: Int) {
        // TODO:- Mark 'completed' boolean as true
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let objectToDelete = result[at] as! TaskEntity
            objectToDelete.completed = true
            print("Task successfully set to 'complete'")
            
        } catch {
            print("Failed to complete task.")
        }
    }
    
}
