//
//  Date+Ext.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 29/1/2024.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
