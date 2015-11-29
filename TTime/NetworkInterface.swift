//
//  NetworkInterface.swift
//  TTime
//
//  Created by auston salvana on 2015-11-28.
//  Copyright © 2015 ARJHack. All rights reserved.
//

import UIKit
import Parse
import SwiftyJSON

class NetworkInterface: NSObject {
    
    func signUpUser(usernameText:String, passwordText:String, completionHandler: () -> Void) {
        
        let createUser = PFUser()
        createUser.username = usernameText
        createUser.password = passwordText
        
        createUser.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if error != nil {
                let errorString = error!.userInfo["error"] as? NSString
                NSLog("%@", errorString!)
            } else {
                // Hooray! Let them use the app now.
                completionHandler()
            }
        }
    }
    
    func saveUserInfo(user:PFUser, nickName:String, street:String, city:String, bio:String, lng:Int, lat:Int) {
        
        user.setObject(nickName, forKey: "nickName")
        user.setObject(street, forKey: "street")
        user.setObject(city, forKey: "city")
        user.setObject(bio, forKey: "bio")
        
        user.setObject(lng, forKey: "lng")
        user.setObject(lat, forKey: "lat")
        
        user.saveInBackground()
    }
    
    func getCoordinates(streetAdress:String, city:String, completionHandler: (lng:Int, lat:Int) -> Void) {
        
        let encodedStreetAddress = encodeURL(streetAdress)
        
        let session = NSURLSession.sharedSession()
        let urlString = "https://api.mapbox.com/geocoding/v5/mapbox.places/\(encodedStreetAddress)%20\(city).json?access_token=pk.eyJ1IjoicGNoaW4iLCJhIjoiY2loanNuZ251MDV3dnRyajcya3JjZHF5cSJ9.jksZA3_D_6wrHqqLQSRykA"
        
        let url = NSURL(string: urlString)
        let dataTask = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            
            let json = JSON(data: data!)
            print("the json \(json)")
            
            if let coordinates = json["features"][0]["geometry"]["coordinates"].array {
                let lng = coordinates[0].int
                let lat = coordinates[1].int
                completionHandler(lng: lng!, lat: lat!)
            }
        })
        dataTask.resume()
        
    }
    
    //MARK: network Helper 
    
    func encodeURL(streetString:String) -> String {
        return streetString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }

}
