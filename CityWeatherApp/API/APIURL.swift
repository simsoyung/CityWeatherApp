//
//  APIURL.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/10/24.
//


import Foundation
import Alamofire

enum WeatherRequest {
    case locationWeather(lat: String, lon: String)
    case cityIdWeather(id: String)
    case locationForecast(lat: String, lon: String)
    case cityIdForecast(id: String)
    case iconWeather(query: String)

    var baseWeatherURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    var iconWeatherURL: String {
        return "https://openweathermap.org/img/wn/"
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
        case .iconWeather(let icon):
            return URL(string: iconWeatherURL + "\(icon)@2x.png")!
        }
    }
    var method: HTTPMethod {
        return .get
    }
    var parameter: Parameters {
        switch self {
        case .locationWeather(let lat, let lon):
            return ["lat": lat , "lon": lon]
        case .cityIdWeather(let id):
            return ["id": id]
        case .locationForecast(let lat, let lon):
            return ["lat": lat , "lon": lon]
        case .cityIdForecast(let id):
            return ["id": id]
        case .iconWeather:
            return ["":""]
        }
    }
    var hearderAPI: HTTPHeaders {
        switch self {
        case .locationWeather, .cityIdWeather, .locationForecast, .cityIdForecast, .iconWeather:
            return ["appid" : "\(APIKey.weatherKey)"]
        }
    }
}

