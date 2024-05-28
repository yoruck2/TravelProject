//
//  NumberFormatter+.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import Foundation

extension Int {
    
    var formatThirdComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let result = numberFormatter.string(from: self as NSNumber) else {
            return ""
        }
        return result
    }
}

