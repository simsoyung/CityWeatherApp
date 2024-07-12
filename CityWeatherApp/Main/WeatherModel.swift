//
//  WeatherModel.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import Foundation

final class WeatherModel{
    let repository = WeatherRepository()
    var inputViewDidLoadTrigger: Observable<Int?> = Observable(0) //처음 id
    var outputWeatherData: Observable<WeatherDecodable?> = Observable(nil) //받은 데이터
    
    init(){
        UserDefaults.standard.set(false, forKey: "isUser")
        transform()
    }
    private func transform(){
        inputViewDidLoadTrigger.bind { _ in
            //self.requestCityId()
            //self.inputViewDidLoadTrigger.value = (1835847)
            self.callRequest()
        }
    }
    private func requestCityId(){
        let idList = repository.fetchCity()
        print(idList)
        let user = UserDefaults.standard.bool(forKey: "isUser")
        if user {
            //가장 마지막에 검색한 내용가져오기
            inputViewDidLoadTrigger.value = (idList[0].cityId)
        } else {
            inputViewDidLoadTrigger.value = (1835847)
        }
    }
    
    private func callRequest(){
        guard let value = inputViewDidLoadTrigger.value else {return}
        print(value)
        ResponseAPI.shared.responseIcon(api: .cityIdWeather(id: value, key: "\(APIKey.weatherKey)"), model: WeatherDecodable.self) { value, imagestr, error  in
            self.outputWeatherData.value = value
        }
//        ResponseAPI.shared.responseAPI(api: .cityIdWeather(id: value), model: [WeatherDecodable].self) { value, error in
//            self.outputWeatherData.value = value
//        }
    }
    private func saveCity(cityId: Int, cityName: String, lat: Double, lon: Double){ //도시랑 내 위치 realm에 저장??
        repository.saveCityDetail(cityId: cityId, cityName: cityName, lat: lat, lon: lon)
    }
    
}

