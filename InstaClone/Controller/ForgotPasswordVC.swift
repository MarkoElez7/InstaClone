//
//  ForgotPasswordVC.swift
//  InstaClone
//
//  Created by Marko  on 8/14/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {

    
    @IBOutlet weak var emailField: CustomTextField!
    
    var fieldsToCheck = Array<UITextField>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func submitBtn(_ sender: Any) {
        fieldsToCheck.append(contentsOf: [emailField])
        if !fieldsToCheck.areFieldsEmpty() {
            Auth.auth().sendPasswordReset(withEmail: emailField.text!) { (error) in
                if error != nil {
                    self.presentAlert(type: .InvalidEmail)
                } else {
                    
                }
            }
        }
    }
    
}
