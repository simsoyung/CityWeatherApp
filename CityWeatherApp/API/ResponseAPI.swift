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
    
    func responseAPI<T: Decodable>(api: WeatherRequest,model: T.Type, completionHandler: @escaping (T? ,String?) -> Void) {
        AF.request(api.endpoint,method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString) ,headers: api.hearderAPI).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(_):
                completionHandler(nil, "검색어를 다시 입력해주세요")
            }
        }
    }

}
