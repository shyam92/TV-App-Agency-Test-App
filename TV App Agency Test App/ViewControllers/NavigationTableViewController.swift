//
//  NavigationTableViewController.swift
//  TV App Agency Test App
//
//  Created by Shyam Bhudia on 29/04/2016.
//  Copyright © 2016 Shyam. All rights reserved.
//

import UIKit

class NavigationTableViewController: UITableViewController {

    var datasource = ["Live TV", "Movies", "Series", "Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: DATASOURCE
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //Maintain 60fps for loading data
        let label = cell.viewWithTag(12) as! UILabel
        label.text = datasource[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //Header cell for the top view
        return tableView.dequeueReusableCellWithIdentifier("headerCell") as UITableViewCell!
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 135
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.revealViewController() != nil {
            //Load the page needed from the nav
            let navController = self.storyboard?.instantiateViewControllerWithIdentifier("ListViewController") as! UINavigationController
            self.revealViewController().setFrontViewController(navController, animated: true)
            self.revealViewController().revealToggleAnimated(true)
        }
    }
}
