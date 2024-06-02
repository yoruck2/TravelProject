//
//  ViewControllerDelegate.swift
//  TravelProject
//
//  Created by dopamint on 5/29/24.
//

import Foundation
import UIKit

@objc
protocol ViewControllerDelegate: AnyObject {
    @objc optional func dismissViewController(label: String, color: UIColor)
    @objc optional func applyData(row: Int, saveCount: Int, isSelected: Bool)
}

