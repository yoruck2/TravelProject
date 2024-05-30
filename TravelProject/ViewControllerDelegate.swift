//
//  ViewControllerDelegate.swift
//  TravelProject
//
//  Created by dopamint on 5/29/24.
//

import Foundation

@objc
protocol ViewControllerDelegate: AnyObject {
    @objc optional func dismissViewController(data: String)
    @objc optional func applyData(row: Int)
    @objc optional func applyData(row: Int, saveCount: Int, isSelected: Bool)
}

