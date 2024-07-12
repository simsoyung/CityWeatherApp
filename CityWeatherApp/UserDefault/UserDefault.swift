//
//  UserDefault.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/12/24.
//

import Foundation

class UserDefaultManager {
    var imageIndex: String{
        get{
            return UserDefaults.standard.string(forKey: "imageNum") ?? ""
        }
        set{
            UserDefaults.standard.set("profile_\(newValue)", forKey: "imageNum")
        }
    }
}
