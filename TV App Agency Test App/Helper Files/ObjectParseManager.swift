//
//  ObjectParseManager.swift
//  TV App Agency Test App
//
//  Created by Shyam Bhudia on 29/04/2016.
//  Copyright © 2016 Shyam. All rights reserved.
//

import UIKit

class ObjectParseManager: NSObject {
    static let sharedManager = ObjectParseManager()
    
    //Data Parser to convert NSData to JSON to Movie Model format
    func parseMovieData(onCompletion: ([Movie])-> Void) {
        var movieData = [Movie]()
        //Download Data
        Net.GETSync(NSURL(string: Const.urlLink)!, completion: { (data, error) in
            if let data = data {
                do {
                    //Convert from NSData to JSON (NSDictionary)
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
                    //Loop through results array to get all movies
                    if let results = json?.objectForKey("results") as? NSArray {
                        for result in (results as? [NSDictionary])! {
                            //Convert JSON to Movie Model object
                            if let movie = Movie(json: result) {
                                movieData.append(movie)
                            }
                        }
                        //Send movie data back
                        onCompletion(movieData)
                    }
                }
                catch {
                    print("Could not parse JSON")
                }
            }
        })
    }
    
    
}
