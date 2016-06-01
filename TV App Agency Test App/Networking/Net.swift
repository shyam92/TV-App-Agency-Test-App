//
//  Net.swift
//  TV App Agency Test App
//
//  Created by Shyam Bhudia on 28/04/2016.
//  Copyright © 2016 Shyam. All rights reserved.
//

import Foundation
class Net {
    
    //Global URL synchronus downloader
    class func GETSync(url: NSURL, completion: ((NSData?, NSError?) -> Void)) -> NSURLSessionDataTask? {
        let request = NSMutableURLRequest(URL: url)
        
        let semaphore = dispatch_semaphore_create(0)
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, _, error) in
            completion(data, error)
            
            dispatch_semaphore_signal(semaphore)
        }
        dataTask.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        return dataTask
    }
    
}
