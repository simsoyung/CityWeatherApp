//
//  WeatherRepository.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import Foundation
import RealmSwift

final class WeatherRepository {
    private let realm = try! Realm()
    
    //검색기록 읽어서 배열에 넣기
    func fetchCity() -> [WeatherRealm] {
        let result = realm.objects(WeatherRealm.self)
        return Array(result)
    }
    
    //검색기록 저장
    func saveCityDetail(cityId: Int, cityName: String, lat: Double, lon: Double){
        let value = WeatherRealm(lon: lon, lat: lat, cityId: cityId, cityName: cityName)
        do{
            try realm.write {
                realm.add(value)
                print("realm 아이템 추가됨!!!")
            }
        } catch {
            print("realm add 에러")
        }
    }
}
