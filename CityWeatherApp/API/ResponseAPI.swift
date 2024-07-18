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
    
    func responseStr<T: Decodable>(api: WeatherRequest,model: T.Type, completionHandler: @escaping (T?, [String]? ,String?) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString)).responseString(completionHandler: { response in
            switch response.result {
            case .success(let value) :
                print("API 응답 ")
            case .failure(let error) :
                print("실패 \(error.localizedDescription)")
            }
        })
    }
    func responseWeather<T: Decodable>(api: WeatherRequest,model: T.Type, completionHandler: @escaping (T?, [String]? ,String?) -> Void) {
        AF.request(api.endpoint,method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString)).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value) :

                if let icon = value as? WeatherDecodable {
                    var iconUrls: [String] = []
                    for forecast in icon.weather {
                        let iconCode = forecast.icon
                        let iconUrlString = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
                        iconUrls.append(iconUrlString)
                    }
                    completionHandler(value, iconUrls, "아이콘 URL 생성")

                } else {
                    completionHandler(value, nil, "아이콘 URL 실패")
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    func responseForecast<T: Decodable>(api: WeatherRequest,model: T.Type, completionHandler: @escaping (T?, [String]?, String?) -> Void) {
        AF.request(api.endpoint,method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString)).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value) :

                if let icon = value as? ForecastDecodable {
                    var iconUrls: [String] = []
                    for forecast in icon.list {
                        if let iconCode = forecast.weather.first?.icon {
                            let iconUrlString = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
                            iconUrls.append(iconUrlString)
                        }
                    }
                    completionHandler(value, iconUrls, "아이콘 URL 생성")
                } else {
                    completionHandler(value, nil, "아이콘 URL 실패")
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}
