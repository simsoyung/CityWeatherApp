//
//  Decoder.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/15/24.
//

import Foundation

class JSONLoader {
    static let shared = JSONLoader()
    private init() {}
    func decodeJSONData(jsonData: Data) -> [DummyData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([DummyData].self, from: jsonData)
            return decodedData
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    func loadJSONFromFile(filename: String) -> [DummyData]? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return decodeJSONData(jsonData: data)
            } catch {
                print("Error loading JSON from file: \(error)")
            }
        }
        return nil
    }
}
