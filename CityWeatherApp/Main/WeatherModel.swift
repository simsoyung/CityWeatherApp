//
//  WeatherModel.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import Foundation

final class WeatherModel{
    let repository = WeatherRepository()
    
    let inputViewDidLoadTrigger: Observable<Int?> = Observable(0) //처음 id
    var outputWeatherData: Observable<[WeatherDecodable]?> = Observable([]) //받은 데이터
    
    init(){
        transform()
    }
    private func transform(){
        inputViewDidLoadTrigger.bind { _ in
            self.callRequest()
        }
        
        
    }
    private func callRequest(){
        ResponseAPI.shared.responseAPI(api: .cityIdWeather(id: ""), model: [WeatherDecodable].self) { value, error in
            self.outputWeatherData.value = value
        }
    }
    private func saveCity(cityId: Int, cityName: String, lat: Double, lon: Double){
        repository.saveCityDetail(cityId: cityId, cityName: cityName, lat: lat, lon: lon)
    }
    
}

