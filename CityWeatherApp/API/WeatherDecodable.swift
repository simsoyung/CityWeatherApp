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
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case coord
        case country
        case population
        case timezone
        case sunrise
        case sunset
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 1835847
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "서울"
        self.coord = try container.decode(Coord.self, forKey: .coord)
        self.country = try container.decode(String.self, forKey: .country)
        self.population = try container.decode(Int.self, forKey: .population)
        self.timezone = try container.decode(Int.self, forKey: .timezone)
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
    }
}


struct MainClass: Decodable {
    let temp, temp_min, temp_max : Double
    let humidity: Int //기압
    let pressure: Int //습도
}
