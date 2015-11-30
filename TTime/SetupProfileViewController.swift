//
//  SetupProfileViewController.swift
//  TTime
//
//  Created by auston salvana on 2015-11-29.
//  Copyright © 2015 ARJHack. All rights reserved.
//

import UIKit
import Parse

class SetupProfileViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {

    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var nickNameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var cityArray:[String]?
    var userGender:String?
    
    let setupStandards = SetupStandard()
    let networkInterface = NetworkInterface()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.title = "Setup Profile"
        
        //make a pickerview model with delegates and datasource
        setup()
    }
    
    //MARK: Helper functions
    
    func setup() {
        cityArray = [
            "Vancouver",
            "Surrey",
            "Abbotsford"
        ]
        setupStandards.underlineTextField(nickNameField)
        setupStandards.underlineTextField(addressField)
        userGender = "Male"
    }

    //MARK: touch delegate
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: uipickerview datasource
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let currentCity = cityArray![row]
        return currentCity
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityArray!.count
    }
    
    //MARK: IBActions
    
    @IBAction func genderSegment(sender: AnyObject) {
        // This all works fine and it prints out the value of 3 on any click
        print("# of Segments = \(sender.numberOfSegments)")
        
        switch sender.selectedSegmentIndex {
        case 0:
            userGender = "Male"
            print("first segement clicked")
        case 1:
            userGender = "Female"
            print("second segment clicked")
        default:
            break;
        }  //Switch
    }
    
    @IBAction func createProfile(sender: AnyObject) {
        
        let user = PFUser.currentUser()
        
        let nickName = nickNameField.text!
        let street = addressField.text!
        let userBio = bioTextView.text!
        let gender = self.userGender!
        
        let cityIndex = cityPicker.selectedRowInComponent(0)
        let city = cityArray![cityIndex]
        
        networkInterface.getCoordinates(street, city: city) { (lng, lat) -> Void in
            self.networkInterface.saveUserInfo(user!, nickName: nickName, street: street, city: city, bio: userBio, gender: gender,  lng: lng, lat: lat)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.performSegueWithIdentifier("MapViewController", sender: self)
            })
        }
        
    }
    

}
