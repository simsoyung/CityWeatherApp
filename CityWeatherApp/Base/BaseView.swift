//
//  BaseView.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy(){
        
    }
    func configureLayout(){
        
    }
    func configureUI(){
        
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


