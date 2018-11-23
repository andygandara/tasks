//
//  AddCategoryVC.swift
//  tasks
//
//  Created by Andy Gandara on 11/22/18.
//  Copyright © 2018 Andy Gandara. All rights reserved.
//

import UIKit

class AddCategoryVC: UIViewController {

    @IBOutlet weak var categoryTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTF.becomeFirstResponder()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    @IBAction func cancel(_ sender: Any) {
        categoryTF.text = nil
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: UIBarPositioningDelegate
extension AddCategoryVC: UIBarPositioningDelegate {
    // see iOS: setting statusbar color without using UINavigationController
    // http://stackoverflow.com/questions/31103076/ios-setting-statusbar-color-without-using-uinavigationcontroller
    // (delegate set in the storyboard)
    // ensures the status bar colour is set to the same as the navigation bar background colour; matches
    // the behaviour of wrapping the ViewController in a NavigationController.
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
