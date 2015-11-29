//
//  ViewController.swift
//  TTime
//
//  Created by auston salvana on 2015-11-28.
//  Copyright © 2015 ARJHack. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let networkInterface = NetworkInterface()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IBActions 
    
    @IBAction func createUser(sender: AnyObject) {
        
        let username = usernameField.text!
        let password = passwordField.text!
        
        networkInterface.signUpUser(username, passwordText: password) { () -> Void in
            //if this completion handler is called then the signup passed
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.performSegueWithIdentifier("FormViewController", sender: self)
            })
        }
    }
    


}

