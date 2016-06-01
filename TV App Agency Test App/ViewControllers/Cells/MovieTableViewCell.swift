//
//  MovieTableViewCell.swift
//  TV App Agency Test App
//
//  Created by Shyam Bhudia on 28/04/2016.
//  Copyright © 2016 Shyam. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movie: Movie? {
        //When movie is set present data to user
        didSet {
            renderCell()
        }
    }

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    func renderCell() {
        titleLabel.text = movie?.title!
        voteCountLabel.text = "Vote total: \(String(movie!.voteCount!))"
        overviewLabel.text = movie?.overview
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        voteCountLabel.text = nil
        overviewLabel.text = nil
        posterImageView.image = nil
    }
}
