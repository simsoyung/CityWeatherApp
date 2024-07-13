//
//  Formatter.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/13/24.
//

import Foundation

final class hourFormatter {
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
    
    static func dayFormatter(dateString: String, todayWeather: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "HH:mm:ss"
            let timeString = dateFormatter.string(from: date)
            if timeString == todayWeather {
                dateFormatter.dateFormat = "EEEE"
                dateFormatter.locale = Locale(identifier: "ko_KR")
                return dateFormatter.string(from: date)
            }
        }
        return nil
    }
    static func dayOfWeek(from dateString: String) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "EEEE"
                dateFormatter.locale = Locale(identifier: "ko_KR")
                return dateFormatter.string(from: date)
            }
            return nil
        }
}
