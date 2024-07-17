//
//  UIView+Identifier.swift
//  Lesson12HW
//

//

import UIKit

extension UIView {
    
    static var reuseIdentifier: String {
        get {
            return String(describing: self)
        }
    }
}
