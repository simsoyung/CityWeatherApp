//
//  Formatter.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/13/24.
//

import Foundation

final class LocationFormatter {
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
    //제일 마지막 시간만 가져오기
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
    //가져온값을 오늘이랑 비교해서 같으면 오늘이라고 표시 아니면 요일별로 표시
    static func dayOfWeek(from dateString: String) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            
            if let date = dateFormatter.date(from: dateString) {
                let calendar = Calendar.current
                if calendar.isDateInToday(date) {
                    return "오늘"
                } else {
                    dateFormatter.dateFormat = "EEEE"
                    return dateFormatter.string(from: date)
                }
            }
            return nil
        }
    static func numFormatNumber(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}
