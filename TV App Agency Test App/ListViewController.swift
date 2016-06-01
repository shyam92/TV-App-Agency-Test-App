//
//  ViewController.swift
//  TV App Agency Test App
//
//  Created by Shyam Bhudia on 28/04/2016.
//  Copyright © 2016 Shyam. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    var dataSource = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Menu setup
        customMenuSetup()
        //Get data in background and show in foreground once downloaded
        ObjectParseManager.sharedManager.parseMovieData { (datasource) in
            self.dataSource = datasource
            //Reload data in main thread
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customMenuSetup() {
        //Assign menu button to the revealController
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    
    @IBAction func searchButtonTapped(sender: AnyObject) {
        //Setup alertController for coming soon message
        let alertController = UIAlertController(title: "Coming Soon", message: "This feature will be available in a future update", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: TableView DataSource Methods
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieTableViewCell
    }
    
    //MARK: TableView DataSource Delegates
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //Load data in willDisplayCell to maintain 60fps scrolling on the tableView
        if let cell = cell as? MovieTableViewCell {
            let movie = dataSource[indexPath.row]
            cell.movie = movie
            let posterlink = Const.imagePrefixLink + movie.posterPath!
            //Download image in background and show in the cell once downloaded
            NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: posterlink)!, completionHandler: { (data, response, error) -> Void in
                if let data = data {
                    let image = UIImage(data: data)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        //Get cell to show the image in
                        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? MovieTableViewCell {
                            cell.posterImageView.image = image
                        }
                    })
                }
            }).resume()
        }
    }
    
    
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Navigate to the detail view and show
        if segue.identifier == "showMovie" {
            if let indexPath = tableView.indexPathForSelectedRow {
                //Hand through selected movie
                let movie = dataSource[indexPath.row]
                let detailViewController = segue.destinationViewController as! DetailViewController
                detailViewController.movie = movie
            }
        }
    }
}

