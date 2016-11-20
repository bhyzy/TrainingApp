//
//  ViewController.swift
//  TrainingApp
//
//  Created by Bartłomiej Hyży on 26/12/15.
//
//

import UIKit
import CoreData

class TrainingListViewController: UITableViewController, TrainingEditViewControllerDelegate, FetchedResultsControllerDataSourceDelegate {
    
    var dataSource: FetchedResultsControllerDataSource!
    var managedObjectContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: pass context or persistent stack from outside
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentStack.managedObjectContext
        
        let trainingsFRC = Training.trainingsFetchedResultsControllerForContext(managedObjectContext)
        dataSource = FetchedResultsControllerDataSource(tableView: tableView, fetchedResultsController: trainingsFRC, delegate: self, reuseIdentifier: "TrainingCell")
    }
    
    // MARK: - Overriden
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.paused = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        dataSource.paused = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddTraining" {
            let navigationController = segue.destinationViewController as! UINavigationController
            presentAddTrainingViewController(navigationController.topViewController as! TrainingEditViewController)
        }
    }
    
    // MARK: - Private Methods
    
    private func presentAddTrainingViewController(controller: TrainingEditViewController) {
        controller.managedObjectContext = managedObjectContext
        controller.delegate = self
    }
    
    // MARK: - TrainingEditViewControllerDelegate
    
    func trainingEditViewControllerDidCancel(controller: TrainingEditViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func trainingEditViewControllerDidCommitChanges(controller: TrainingEditViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - FetchedResultsControllerDataSourceDelegate
    
    func configureCell(cell: AnyObject, withObject object: AnyObject) {
        let training = object as! Training
        let tableViewCell = cell as! UITableViewCell
        tableViewCell.textLabel?.text = training.name
    }
    
    func deleteObject(object: AnyObject) {
        // TODO: implement
    }

}

