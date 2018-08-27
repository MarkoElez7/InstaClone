//
//  LoginErrorAlerts.swift
//  InstaClone
//
//  Created by Marko  on 8/16/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(type: Alert) {
        let alert: UIAlertController = {
            switch type {
            case .EmptyFields:
                return UIAlertController(title: "Error", message: "Please ensure all text fields are filled", preferredStyle: .alert)
            case .FieldsNotMatching:
                return UIAlertController(title: "Error", message: "Fields do not match", preferredStyle: .alert)
            case .EmailAlreadyTaken:
                return UIAlertController(title: "Error", message: "Email already in use", preferredStyle: .alert)
            case .InvalidEmail:
                return UIAlertController(title: "Error", message: "Not a valid email", preferredStyle: .alert)
            case .IncorrectLogin:
                return UIAlertController(title: "Error", message: "Email or password is incorrect", preferredStyle: .alert)
            case .PasswordTooShort:
                return UIAlertController(title: "Error", message: "Password must be at least 6 characters long", preferredStyle: .alert)
            case .CreateUserError:
                return UIAlertController(title: "Error", message: "Error in creating user, please try again", preferredStyle: .alert)
            }
        }()
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    
    
    
    
    
    
}
