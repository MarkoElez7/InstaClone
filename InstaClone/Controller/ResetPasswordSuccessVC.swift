//
//  ResetPasswordSuccessVC.swift
//  InstaClone
//
//  Created by Marko  on 8/14/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit

class ResetPasswordSuccessVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func homeBtnPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    

}
