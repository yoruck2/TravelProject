//
//  DateFormmater.swift
//  TravelProject
//
//  Created by dopamint on 5/27/24.
//

import Foundation

extension DateFormatter {
    
    func formatKoreanDate(inputDate: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        
        guard let date = formatter.date(from: inputDate) else {
            return nil
        }
        
        formatter.dateFormat = "yy년 M월 d일"
        
        let outputDate = formatter.string(from: date)
        return outputDate
    }
}
