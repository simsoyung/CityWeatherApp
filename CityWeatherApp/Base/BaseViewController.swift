//
//  BaseViewController.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/10/24.
//

import UIKit

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    func configureHierarchy() {
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureConstraints() {
    }
    
}
