//
//  DetailViewController.swift
//  TV App Agency Test App
//
//  Created by Shyam Bhudia on 29/04/2016.
//  Copyright © 2016 Shyam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //Content Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    //Share Outlets
    @IBOutlet weak var backgroundShareView: UIView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentInset = UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0)
        //Set view to round itself
        backgroundShareView.layer.cornerRadius = 25
        //Set data to show on screen
        titleLabel.text = movie?.title
        voteCountLabel.text = "Vote total: \(movie!.voteCount!)"
        releaseDateLabel.text = "Release Date: \(movie!.releaseDate!)"
        overviewLabel.text = movie?.overview
        //Download and show poster
        let posterlink = Const.imagePrefixLink + movie!.backdropPath!
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: posterlink)!, completionHandler: { (data, response, error) -> Void in
            if let data = data {
                let image = UIImage(data: data)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //Show poster on main thread
                    self.posterImageView.image = image
                })
            }
        }).resume()
    }
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        //Set text to share
        let textToShare = movie!.title! + " - " + movie!.overview!
        
        let objectsToShare = [textToShare]
        //Instanstiate Activity View Controller to show share sheet
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
        self.presentViewController(activityVC, animated: true, completion: nil)
        
    }
}
