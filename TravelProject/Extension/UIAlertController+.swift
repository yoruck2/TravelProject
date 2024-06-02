//
//  UIAlertController.swift
//  TravelProject
//
//  Created by dopamint on 6/1/24.
//

import UIKit

extension UIAlertController {
    
    func addAction(_ title: String, _ style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) {
        self.addAction(UIAlertAction(title: title, style: style, handler: handler))
    }
}
