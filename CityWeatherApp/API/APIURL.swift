//
//  APIURL.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/10/24.
//


import Foundation
import Alamofire

enum WeatherRequest {
    case locationWeather(lat: Double, lon: Double, key: String)
    case cityIdWeather(id: Int, key: String)
    case locationForecast(lat: Double, lon: Double, key: String)
    case cityIdForecast(id: Int, key: String)

    var baseWeatherURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    var endpoint: URL {
        switch self {
        case .locationWeather:
            return URL(string: baseWeatherURL + "weather?")!
        case .cityIdWeather:
            return URL(string: baseWeatherURL + "weather?")!
        case .locationForecast:
            return URL(string: baseWeatherURL + "forecast?")!
        case .cityIdForecast:
            return URL(string: baseWeatherURL + "forecast?")!
        }
    }
    var method: HTTPMethod {
        return .get
    }
    var parameter: Parameters {
        switch self {
        case .locationWeather(let lat, let lon, let key):
            return ["lat": lat , "lon": lon, "appid": key]
        case .cityIdWeather(let id, let key):
            return ["id": id, "appid": key]
        case .locationForecast(let lat, let lon, let key):
            return ["lat": lat , "lon": lon, "appid": key]
        case .cityIdForecast(let id, let key):
            return ["id": id, "appid": key]
        }
    }
}

