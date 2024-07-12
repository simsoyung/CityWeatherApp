//
//  RealmModel.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import Foundation
import RealmSwift

final class WeatherRealm: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var lon: Double
    @Persisted var lat: Double
    @Persisted var cityId: Int
    @Persisted var cityName: String
    
    convenience init(lon: Double, lat: Double, cityId: Int, cityName: String) {
        self.init()
        self.lon = lon
        self.lat = lat
        self.cityId = cityId
        self.cityName = cityName
    }
}
