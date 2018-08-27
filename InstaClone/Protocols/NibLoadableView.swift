//
//  NibLoadableView.swift
//  InstaClone
//
//  Created by Marko  on 8/17/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension FeedCell: NibLoadableView {}
