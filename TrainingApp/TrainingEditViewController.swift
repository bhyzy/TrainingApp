//
//  TrainingEditViewController.swift
//  TrainingApp
//
//  Created by Bartłomiej Hyży on 08/01/16.
//
//

import UIKit

protocol TrainingEditViewControllerDelegate {
    func trainingEditViewControllerDidCancel(controller: TrainingEditViewController)
    func trainingEditViewControllerDidCommitChanges(controller: TrainingEditViewController)
}

class TrainingEditViewController: UITableViewController {

    var training: Training!
    
    var delegate: TrainingEditViewControllerDelegate?
    
    @IBOutlet weak var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var commitBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if training != nil {
            // TODO: initialize UI with training details
            navigationItem.title = NSLocalizedString("Edit Training", comment: "Title of the screen for editing an existing training")
        } else {
            // TODO: create new training in a draft context if necessary
            navigationItem.title = NSLocalizedString("Add Training", comment: "Title of the screen for adding a new training")
        }
    }
    
    @IBAction func cancelItemTapped(sender: AnyObject) {
        delegate?.trainingEditViewControllerDidCancel(self)
    }

    @IBAction func commitItemTapped(sender: AnyObject) {
        delegate?.trainingEditViewControllerDidCommitChanges(self)
    }
    
}
