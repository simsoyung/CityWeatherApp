//
//  WeatherDecodable.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/10/24.
//

import UIKit

struct WeatherDecodable: Decodable {
    let coord: Coord
    let main: Temp
    let wind: Wind
    let weather: [Weather]
    let clouds: Clouds
    let name: String
    let id: Int
    let timezone: Int
}

struct Coord: Decodable {
    let lon, lat: Double
}

struct Temp: Decodable {
    let temp, tempMin, tempMax : Double
    let humidity: Int //기압
    let pressure: Int //습도
}

struct Wind: Decodable {
    let speed: Double
}

struct Weather: Decodable {
    let id: Int
    let icon: String
}

struct Clouds: Decodable {
    let all: Int //구름
}
