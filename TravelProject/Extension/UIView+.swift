//
//  UIView+.swift
//  TravelProject
//
//  Created by dopamint on 6/20/24.
//

import Foundation
import UIKit

extension UIView {
    func configureShadow() {
        
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 4
        layer.shadowOffset = .init(width: 5, height: 5)
        layer.masksToBounds = false
    }
}
