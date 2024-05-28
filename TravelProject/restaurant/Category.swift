//
//  Category.swift
//  TravelProject
//
//  Created by dopamint on 5/29/24.
//

import UIKit

enum Category: String {
    case korean = "한식"
    case cafe = "카페"
    case chinese = "중식"
    case snackBar = "분식"
    case japanese = "일식"
    case western = "양식"
    case lightWestern = "경양식"
    
    func categoryColor() -> UIColor {
        switch self {
        case .korean:
            return #colorLiteral(red: 0.1098039216, green: 0.7294117647, blue: 0.9764705882, alpha: 1)
        case .cafe:
            return #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
        case .chinese:
            return #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        case .snackBar:
            return #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        case .japanese:
            return #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
        case .western:
            return #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
        case .lightWestern:
            return #colorLiteral(red: 0.8212783933, green: 0.8085442185, blue: 0.07338868827, alpha: 1)
        }
    }
}
