//
//  BorderlessNavBar.swift
//  InstaClone
//
//  Created by Marko  on 8/13/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit

class BorderlessNavBar: UINavigationBar {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        
    }
}
