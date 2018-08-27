//
//  ReusableView.swift
//  InstaClone
//
//  Created by Marko  on 8/17/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension FeedCell: ReusableView {}
