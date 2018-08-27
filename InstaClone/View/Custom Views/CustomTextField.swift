//
//  CustomTextField.swift
//  InstaClone
//
//  Created by Marko  on 8/8/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.borderStyle = .none
        self.backgroundColor = UIColor.clear
        let width: CGFloat = 1.0
        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width))
        borderLine.backgroundColor = PINK_COLOR
        self.addSubview(borderLine)
        self.textColor = WHITE_COLOR
    }
}
