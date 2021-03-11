//
//  UIView+Extension.swift
//  Assignment
//
//  Created by Savleen on 11/03/21.
//

import Foundation
import UIKit

extension UIView {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }
}
