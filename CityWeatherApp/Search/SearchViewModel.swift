//
//  SearchViewModel.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/15/24.
//

import Foundation

final class SearchViewModel {
    var outputData: Observable<ForecastDecodable?> = Observable(nil)
    
    init(){
        print("Detail!!!!!!", outputData.value)
    }
}
