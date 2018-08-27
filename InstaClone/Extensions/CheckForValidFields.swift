//
//  CheckForValidEmail.swift
//  InstaClone
//
//  Created by Marko  on 8/14/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit

extension UITextField {
    func isValidEmail() -> Bool {
        if self.text!.contains("@") && self.text!.hasSuffix("com") {
            return true        
        }
        return false
    }
}

extension UIViewController {
    
    func checkMatchingFields(fieldOne: UITextField, fieldTwo: UITextField) -> Bool {
        if let fieldOne = fieldOne.text, let fieldTwo = fieldTwo.text {
            if fieldOne == fieldTwo {
                return true
            }
        }
        return false
    }
    
}

extension Array where Element == UITextField {
    
    func areFieldsEmpty() -> Bool {
        for element in self {
            if let element = element.text {
                if element.isEmpty {
                    return true
                }
            }
        }
        return false
    }
    
    func arePasswordsValid() -> Bool {
        for element in self {
            if let element = element.text {
                if !element.isEmpty, element.count >= 6 {
                    return true
                }
            }
        }
        return false
    }
    
}
