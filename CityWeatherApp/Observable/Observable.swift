//
//  Observable.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import Foundation

class Observable<T>{
    var closure: ((T) -> Void)?
    var value: T {
        didSet {
            closure?(value)
        }
    }
    init(_ value: T){
        self.value = value
    }
    func bind(closure: @escaping (T) -> Void){
        closure(value)
        self.closure = closure
    }
    func bindOption(closure: @escaping (T) -> Void){
        self.closure = closure
    }
}
