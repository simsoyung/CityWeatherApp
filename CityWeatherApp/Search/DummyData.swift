//
//  DummyData.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/15/24.
//

import Foundation

struct DummyData: Decodable {
    let id: Int
    let name, state, country: String
    let coord: Location
}

struct Location: Decodable {
    let lon, lat: Double
}
