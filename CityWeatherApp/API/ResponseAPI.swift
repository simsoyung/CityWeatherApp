//
//  ResponseAPI.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/10/24.
//

import UIKit
import Alamofire

class ResponseAPI {
    static let shared = ResponseAPI()
    private init() {}
    
    func responseWeather<T: Decodable>(api: WeatherRequest,model: T.Type, completionHandler: @escaping (T?, String? ,String?) -> Void) {
        AF.request(api.endpoint,method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString)).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value) :
                print(value)
                if let icon = value as? WeatherDecodable {
                    let iconCode = icon.weather.first?.icon ?? ""
                    let iconUrlString = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
                        completionHandler(value, iconUrlString, "아이콘 URL 생성 실패")
                } else {
                    completionHandler(value, nil, "WeatherDecodable 캐스팅 실패")
                }
            case .failure(let error) :
                print(error)
            }
        }
    }
    func responseForecast<T: Decodable>(api: WeatherRequest,model: T.Type, completionHandler: @escaping (T?, String? ,String?) -> Void) {
        AF.request(api.endpoint,method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString)).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value) :
                print(value)
                if let icon = value as? ForecastDecodable {
                    let iconCode = icon.list.first?.weather.first?.icon ?? ""
                    let iconUrlString = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
                        completionHandler(value, iconUrlString, "아이콘 URL 생성 실패")
                } else {
                    completionHandler(value, nil, "WeatherDecodable 캐스팅 실패")
                }
            case .failure(let error) :
                print(error)
            }
        }
    }
}
