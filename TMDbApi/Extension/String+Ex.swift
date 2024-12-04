//
//  String+Ex.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 29/11/2024.
//

import Foundation

extension String {
    var releaseYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            let year = Calendar.current.component(.year, from: date)
            return String(year)
        }
        return "N/A"
    }
    
    var releaseYearAndMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            let year = Calendar.current.component(.year, from: date)
            let month = Calendar.current.component(.month, from: date)
            let formattedMonth = String(format: "%02d", month)
            return "\(year)-\(formattedMonth)"
        }
        return "N/A"
    }
}
