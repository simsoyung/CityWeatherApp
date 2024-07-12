//
//  WeatherDecodable.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/10/24.
//

import UIKit

struct WeatherDecodable: Decodable {
    let coord: Coord
    let main: MainWeather
    let wind: Wind
    let weather: [Weather]
    let clouds: Clouds
    let name: String
    let id: Int
    let timezone: Int
}

struct Coord: Decodable {
    let lat: Double
    let lon: Double
}
struct MainWeather: Decodable {
    let temp, temp_min, temp_max : Double
    let humidity: Int //기압
    let pressure: Int //습도
}

struct Wind: Decodable {
    let speed: Double
}

struct Weather: Decodable {
    let id: Int
    let icon: String
    let description: String
    let main: String
}

struct Clouds: Decodable {
    let all: Int //구름
}

// MARK: Forecast

struct ForecastDecodable: Decodable {
    let list: [WeatherList]
    let city: City
}
struct WeatherList: Decodable {
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let dt_txt: String
}
struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

struct MainClass: Decodable {
    let temp, temp_min, temp_max : Double
    let humidity: Int //기압
    let pressure: Int //습도
}
