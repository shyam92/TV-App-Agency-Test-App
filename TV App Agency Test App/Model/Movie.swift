//
//  Movie.swift
//  TV App Agency Test App
//
//  Created by Shyam Bhudia on 28/04/2016.
//  Copyright © 2016 Shyam. All rights reserved.
//

import Foundation

class Movie {
    //Model
    var posterPath: String?
    var adult: Bool?
    var overview: String?
    var releaseDate: String?
    var genreIds: [Int]?
    var id: Int?
    var originalTitle: String?
    var originalLanguage: String?
    var title: String?
    var backdropPath: String?
    var popularity: Double?
    var voteCount: Int?
    var video: Bool?
    var voteAverage: Double?
    
    
    init?(json: NSDictionary) {
        self.posterPath = json.objectForKey("poster_path") as? String
        self.adult = json.objectForKey("adult") as? Bool
        self.overview = json.objectForKey("overview") as? String
        self.releaseDate = json.objectForKey("release_date") as? String
        self.genreIds = [Int]()
        if let genreIds = json.objectForKey("genre_ids") as? [Int] {
            for genreId in genreIds {
                self.genreIds?.append(genreId)
            }
        }
        self.id = json.objectForKey("id") as? Int
        self.originalTitle = json.objectForKey("original_title") as? String
        self.originalLanguage = json.objectForKey("original_language") as? String
        self.title = json.objectForKey("title") as? String
        self.backdropPath = json.objectForKey("backdrop_path") as? String
        self.popularity = json.objectForKey("popularity") as? Double
        self.voteCount = json.objectForKey("vote_count") as? Int
        self.video = json.objectForKey("video") as? Bool
        self.voteAverage = json.objectForKey("vote_average") as? Double
        
    }
}