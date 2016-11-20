//
//  TrainingEditViewController.swift
//  TrainingApp
//
//  Created by Bartłomiej Hyży on 08/01/16.
//
//

import UIKit
import CoreData

protocol TrainingEditViewControllerDelegate {
    func trainingEditViewControllerDidCancel(controller: TrainingEditViewController)
    func trainingEditViewControllerDidCommitChanges(controller: TrainingEditViewController)
}

class TrainingEditViewController: UITableViewController {

    var training: Training?
    var managedObjectContext: NSManagedObjectContext?
    
    var delegate: TrainingEditViewControllerDelegate?
    
    @IBOutlet weak var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var commitBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: - Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if managedObjectContext == nil {
            managedObjectContext = training?.managedObjectContext
        }
        assert(managedObjectContext != nil, "Missing managed object context")
        
        if let existingTraining = training {
            navigationItem.title = NSLocalizedString("Edit Training", comment: "Title of the screen for editing an existing training")
            updateUIWithTraining(existingTraining)
        } else {
            navigationItem.title = NSLocalizedString("Add Training", comment: "Title of the screen for adding a new training")
        }
    }
    
    // MARK: - UI Actions
    
    @IBAction func cancelItemTapped(sender: AnyObject) {
        delegate?.trainingEditViewControllerDidCancel(self)
    }

    @IBAction func commitItemTapped(sender: AnyObject) {
        commitEditing()
        delegate?.trainingEditViewControllerDidCommitChanges(self)
    }
    
    // MARK: - Private Methods
    
    private func updateUIWithTraining(training: Training) {
        nameTextField.text = training.name
    }
    
    private func commitEditing() {
        if training == nil {
            training = Training.create("", inContext: managedObjectContext!)
        }
        let editedTraining = training!
        editedTraining.name = nameTextField.text
    }
    
}
