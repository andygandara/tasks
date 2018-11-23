//
//  AddTaskVC.swift
//  tasks
//
//  Created by Andy Gandara on 11/22/18.
//  Copyright © 2018 Andy Gandara. All rights reserved.
//

import UIKit

class AddTaskVC: UITableViewController {
    
    var hideCategoryPicker = true
    var hideDatePicker = true
    
    @IBOutlet weak var selectedCategoryLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    var categoryPickerData = ["None"]

    // UI items
    @IBOutlet weak var taskTF: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    //@IBOutlet weak var categoryPickerCell: UITableViewCell!
    //@IBOutlet weak var datePickerCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss keyboard on tap
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        // Hide unused cells
        tableView.tableFooterView = UIView()
        
        // Add categories to picker data
        let records = CategoryModel().fetchRecords()
        for record in records {
            if let title = record.title {
                categoryPickerData.append(title)
            }
        }
        print("categoryPickerData: \(categoryPickerData)")
        
        // Set default values
        selectedCategoryLabel.text = categoryPickerData.first
        selectedDateLabel.text = datePicker.date.description
        
        // Connect data to categoryPicker
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        // Open up keyboard
        taskTF.becomeFirstResponder()
    }

    // MARK:- Button Actions
    @IBAction func cancel(_ sender: Any) {
        taskTF.text = nil
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showHideCategoryPicker(_ sender: Any) {
        //categoryPickerCell.isHidden = !categoryPickerCell.isHidden
        hideCategoryPicker = !hideCategoryPicker
        tableView.reloadData()
    }
    
    @IBAction func showHideDatePicker(_ sender: Any) {
        //datePickerCell.isHidden = !datePickerCell.isHidden
        hideDatePicker = !hideDatePicker
        tableView.reloadData()
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        selectedDateLabel.text = sender.date.description
    }
    
    // Changes row height when showing/hiding pickers
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight: CGFloat = 0.0
        
        // Category picker row
        if indexPath.row == 2 {
            if hideCategoryPicker {
                rowHeight = 0.0
            } else {
                rowHeight = 150.0
            }
        }
        // Date picker row
        else if indexPath.row == 4 {
            if hideDatePicker {
                rowHeight = 0.0
            } else {
                rowHeight = 150.0
            }
        }
        // Everything else
        else {
            rowHeight = 50.0    //or whatever you like
        }
        return rowHeight
    }
}

extension AddTaskVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategoryLabel.text = categoryPickerData[row]
    }
    
}
