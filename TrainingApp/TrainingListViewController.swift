//
//  ViewController.swift
//  TrainingApp
//
//  Created by Bartłomiej Hyży on 26/12/15.
//
//

import UIKit

class TrainingListViewController: UITableViewController, FetchedResultsControllerDataSourceDelegate {
    
    var dataSource: FetchedResultsControllerDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: pass context or persistent stack from outside
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.persistentStack.managedObjectContext
        
        let trainingsFRC = Training.trainingsFetchedResultsControllerForContext(context)
        dataSource = FetchedResultsControllerDataSource(tableView: tableView, fetchedResultsController: trainingsFRC, delegate: self, reuseIdentifier: "TrainingCell")
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

