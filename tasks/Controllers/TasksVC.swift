//
//  TasksVC.swift
//  tasks
//
//  Created by Andy Gandara on 11/22/18.
//  Copyright © 2018 Andy Gandara. All rights reserved.
//

import UIKit

class TasksVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide unused cells
        tableView.tableFooterView = UIView()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskModel().fetchRecords().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)

        

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    @IBAction func returnedFromAdd(segue: UIStoryboardSegue) {
        if segue.source is AddTaskVC {
            if let senderVC = segue.source as? AddTaskVC {
                if let task = senderVC.taskTF.text, task != "", let category = senderVC.selectedCategoryLabel.text {
                    let date = senderVC.datePicker.date
                    TaskModel().add(title: task, category: category, date: date)
                    print("task: \(task)")
                    print("category: \(category)")
                    print("date: \(date)\n")
                    tableView.reloadData()
                } else {
                    print("Incomplete data.")
                }
            }
        }
    }
}
