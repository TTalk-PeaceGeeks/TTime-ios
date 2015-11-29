//
//  FormViewController.swift
//  TTime
//
//  Created by auston salvana on 2015-11-28.
//  Copyright © 2015 ARJHack. All rights reserved.
//

import UIKit
import Parse

class FormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var nickNameField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    
    @IBOutlet weak var cityPickerView: UIPickerView!
    var cityArray:[String]?
    
    let networkInterface = NetworkInterface()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityArray = [
            "Vancouver",
            "Surrey",
            "Abbotsford"
        ]
    }
    
    //MARK: helper functions
    
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
    
    @IBAction func doneForm(sender: AnyObject) {
        
        let user = PFUser.currentUser()
        
        let nickName = nickNameField.text!
        let street = streetField.text!
        let userBio = bioTextView.text!
        
        let cityIndex = cityPickerView.selectedRowInComponent(0)
        let city = cityArray![cityIndex]
        
        networkInterface.getCoordinates(street, city: city) { (lng, lat) -> Void in
            self.networkInterface.saveUserInfo(user!, nickName: nickName, street: street, city: city, bio: userBio, lng: lng, lat: lat)
        }
    
    }
    

}
