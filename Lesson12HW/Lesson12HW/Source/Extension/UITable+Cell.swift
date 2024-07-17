//
//  UITable+Cell.swift
//  Lesson12HW
//
//  Created by Pavel on 17.07.2024.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerMainPlaylistCell () {
        
        let nib = UINib (nibName: "MainPlaylistCell", bundle: nil)
        
        register(nib, forCellReuseIdentifier: MainPlaylistCell.reuseIdentifier)
    }
}
