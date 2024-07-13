//
//  Formatter.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/13/24.
//

import Foundation

class hourFormatter {
    static func hourFormatter(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "HH시"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
