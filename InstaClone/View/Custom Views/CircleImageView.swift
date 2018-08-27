//
//  CircleImageView.swift
//  InstaClone
//
//  Created by Marko  on 8/17/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width/2
        clipsToBounds = true
        
    }

}
