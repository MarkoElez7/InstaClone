//
//  SignupVC.swift
//  InstaClone
//
//  Created by Marko  on 8/8/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: UIViewController {

    @IBOutlet weak var nameField: CustomTextField!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var confirmEmailField: CustomTextField!
    
    var fieldsToCheck = Array<UITextField>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBtn = UIBarButtonItem()
        navBtn.title = "Back"
        navigationItem.backBarButtonItem = navBtn
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNextSignupScreen" {
            let nextSignupVC = segue.destination as! FinishSignupVC
            nextSignupVC.name = nameField.text!
            nextSignupVC.email = emailField.text!
        }
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        fieldsToCheck.append(contentsOf: [nameField, emailField, confirmEmailField])
        if !fieldsToCheck.areFieldsEmpty(){
            if checkMatchingFields(fieldOne: emailField, fieldTwo: confirmEmailField) {
                if emailField.isValidEmail() {
                    Auth.auth().fetchProviders(forEmail: emailField.text!) { (providers, error) in
                        if providers == nil {
                            self.performSegue(withIdentifier: "toNextSignupScreen", sender: self)
                        } else {
                            self.presentAlert(type: .EmailAlreadyTaken)
                        }
                    }
                } else {
                    presentAlert(type: .InvalidEmail)
                }
            } else {
                presentAlert(type: .FieldsNotMatching)
            }
        } else {
            print("XYZ: no text entered")
            presentAlert(type: .EmptyFields)
        }
    }
    

}
