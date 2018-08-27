//
//  ViewController.swift
//  InstaClone
//
//  Created by Marko  on 8/8/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LoginVC: UIViewController {

    @IBOutlet weak var loginBtn: RoundedButton!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    var fieldsToCheck = Array<UITextField>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: FEED_ID, sender: self)
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        fieldsToCheck.append(contentsOf: [emailField, passwordField])
        if !fieldsToCheck.areFieldsEmpty() {
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                if error == nil {
                    print("XYZ: Signed in successfully")
                    if let user = user {
                        let userData = ["provider": user.user.providerID]
                        completeSignIn(id: user.user.uid, userData: userData)
                    }
                } else {
                    print("XYZ: error")
                    self.presentAlert(type: .IncorrectLogin)
                    self.passwordField.text = ""
                }
            }
        } else {
            print("XYZ: no text entered")
            presentAlert(type: .EmptyFields)
        }
        
        func completeSignIn(id: String, userData: Dictionary<String, String>) {
            KeychainWrapper.standard.set(id, forKey: KEY_UID)
            performSegue(withIdentifier: FEED_ID, sender: self)
        }
    }
    
}

