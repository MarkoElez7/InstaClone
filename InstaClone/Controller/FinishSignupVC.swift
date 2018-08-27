//
//  FinishSignupVC.swift
//  InstaClone
//
//  Created by Marko  on 8/14/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit
import Firebase

class FinishSignupVC: UIViewController {
    
    var name = ""
    var email = ""
    
    @IBOutlet weak var pwdField: CustomTextField!
    @IBOutlet weak var confirmPwdField: CustomTextField!
    
    var fieldsToCheck = Array<UITextField>()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func submitBtnPressed(_ sender: Any) {
        fieldsToCheck.append(contentsOf: [pwdField, confirmPwdField])
        if fieldsToCheck.arePasswordsValid() {
            if checkMatchingFields(fieldOne: pwdField, fieldTwo: confirmPwdField) {
                print("XYZ: passwords match")
                Auth.auth().createUser(withEmail: email, password: pwdField.text!) { (user, error) in
                    if error == nil {
                        if let user = user {
                            let userData = ["provider": user.user.providerID, "username": self.name]
                            DataService.ds.createFirebaseDatabaseUser(uid: user.user.uid, userData: userData)
                            print("XYZ: user created")
                            self.presentLoginAlert()
                        }
                    } else {
                        print("XYZ: error in creating user")
                        self.presentAlert(type: .CreateUserError)
                    }
                }
            } else {
                presentAlert(type: .FieldsNotMatching)
            }
        } else {
            print("XYZ: Must be at least 6 characters long")
            presentAlert(type: .PasswordTooShort)
        }
    }
    
    func presentLoginAlert() {
        let alert = UIAlertController(title: "Congrats!", message: "User has been created", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Login now", style: .default) { alert in
            self.navigationController?.popToRootViewController(animated: true)
        })
        self.present(alert, animated: true, completion:  nil)
    }

}
