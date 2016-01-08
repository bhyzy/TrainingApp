//
//  FetchedResultsControllerDataSource.swift
//  TrainingApp
//
//  Created by Bartłomiej Hyży on 03/01/16.
//
//

import Foundation
import CoreData
import UIKit

protocol FetchedResultsControllerDataSourceDelegate {
    func configureCell(cell: AnyObject, withObject object: AnyObject)
    func deleteObject(object: AnyObject)
}

@objc class FetchedResultsControllerDataSource: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    let tableView: UITableView
    let fetchedResultsController: NSFetchedResultsController
    let delegate: FetchedResultsControllerDataSourceDelegate
    let reuseIdentifier: String
    
    init(tableView: UITableView, fetchedResultsController: NSFetchedResultsController, delegate: FetchedResultsControllerDataSourceDelegate, reuseIdentifier: String) {
        self.tableView = tableView
        self.fetchedResultsController = fetchedResultsController
        self.delegate = delegate
        self.reuseIdentifier = reuseIdentifier
        
        super.init()
        
        fetchedResultsController.delegate = self
        performFetch()
        
        tableView.dataSource = self
    }
    
    var paused: Bool = false {
        didSet {
            if paused {
                fetchedResultsController.delegate = nil
            } else {
                fetchedResultsController.delegate = self
                performFetch()
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            NSLog("Failed to perform fetch request: \(error)")
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let object = fetchedResultsController.objectAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        delegate.configureCell(cell, withObject: object)
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            delegate.deleteObject(fetchedResultsController.objectAtIndexPath(indexPath))
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        case .Move:
            tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        default:
            // TODO: report error?
            break
        }
    }
    
}
