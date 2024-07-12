//
//  WeatherModel.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import Foundation

final class WeatherModel{
    
    let repository = WeatherRepository()
    let location = LocationManager()
    var getLocation: ((Double, Double) -> Void)?
    
    var inputViewDidLoadTrigger: Observable<Int?> = Observable(0) //처음 id
    var inputViewDidLoadLat: Double = 0 //사용자 lat
    var inputViewDidLoadLon: Double = 0 //사용자 lon
    
    var outputWeatherData: Observable<WeatherDecodable?> = Observable(nil) //받은 전체 데이터
    var outputForecastData: Observable<ForecastDecodable?> = Observable(nil)
    var outputIconList: Observable<[Weather]> = Observable([])
    var outputTimeList: Observable<[WeatherList]> = Observable([])

    init(){
        //UserDefaults.standard.set(false, forKey: "isUser")
        transform()
        location.delegate = self
    }
    private func transform(){
        inputViewDidLoadTrigger.bind { _ in
            //self.requestCityId()
            //self.inputViewDidLoadTrigger.value = (1835847)
            self.callRequest()
            self.location.startUpdatingLocation()
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
//        ResponseAPI.shared.responseWeather(api: .locationWeather(lat: 0, lon: 0, key: "\(APIKey.weatherKey)"), model: WeatherDecodable.self) { value, imagestr, error  in
//            print("도시 현재날씨")
//            self.outputWeatherData.value = value
//        }
//        ResponseAPI.shared.responseWeather(api: .cityIdWeather(id: 1835847, key: "\(APIKey.weatherKey)"), model: WeatherDecodable.self) { value, imagestr, error  in
//            print("위치 현재날씨")
//            self.outputWeatherData.value = value
//        }
//        ResponseAPI.shared.responseForecast(api: .locationForecast(lat: 37.4454, lon: 127.0833, key: "\(APIKey.weatherKey)"), model: ForecastDecodable.self) { value, imagestr, error  in
//            print("도시 3시간 단위 날씨")
//            self.outputForecastData.value = value
//        }
//        ResponseAPI.shared.responseForecast(api: .cityIdForecast(id: 1835847, key: "\(APIKey.weatherKey)"), model: ForecastDecodable.self) { value, imagestr, error  in
//            print("위치 3시간 단위 날씨")
//            self.outputForecastData.value = value
//        }
    }
    private func saveCity(cityId: Int, cityName: String, lat: Double, lon: Double){ //도시랑 내 위치 realm에 저장??
        repository.saveCityDetail(cityId: cityId, cityName: cityName, lat: lat, lon: lon)
    }
    
}

extension WeatherModel: LocationManagerDelegate {
    func didFailWithError(error: any Error) {
        let defaultLat: Double = 37.517742
        let defaultLon: Double = 126.886463
        getLocation?(defaultLat, defaultLon)
        inputViewDidLoadLat = defaultLat
        inputViewDidLoadLon = defaultLon
        print("위치 허용 안함!!", defaultLat, defaultLon)
    }
    
    func didUpdateLocations(lat: Double, lon: Double) {
        getLocation?(lat, lon)
        inputViewDidLoadLat = lat
        inputViewDidLoadLon = lon
        print(lat, lon)
    }
}
