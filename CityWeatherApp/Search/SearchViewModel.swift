//
//  SearchViewModel.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/15/24.
//

import Foundation

final class SearchViewModel {
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var outputData: Observable<[DummyData]> = Observable([])
    
    init(){
        print("init")
        load()
    }
    deinit {
        print("deinit")
    }
    private func load(){
        inputViewDidLoadTrigger.bind { [ weak self ] _ in
            self?.decodeJSON()
        }
    }
    private func decodeJSON(){
        if let outputData = JSONLoader.shared.loadJSONFromFile(filename: "CityList") {
            for dummyData in outputData {
                self.outputData.value = outputData
            }
        } else {
            print("no file")
        }
    }
}
