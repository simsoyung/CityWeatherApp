//
//  MainLocationView.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/10/24.
//

import UIKit
import SnapKit

final class MainLocationView: BaseView {
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 40, weight: .light)
        label.textAlignment = .center
        label.text = "Jeju city"
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 90, weight: .thin)
        label.textAlignment = .center
        label.text = "5.9°"
        return label
    }()
    
    private lazy var weatherTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textAlignment = .center
        label.text = "Jeju city"
        return label
    }()
    
    private lazy var minmaxLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textAlignment = .center
        label.text = "Jeju city"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    override func configureHierarchy(){
        addSubview(locationLabel)
        addSubview(tempLabel)
        addSubview(weatherTextLabel)
        addSubview(minmaxLabel)
    }
    override func configureLayout(){
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(5)
            make.height.equalTo(90)
            make.centerX.equalToSuperview()
        }
        weatherTextLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(5)
            make.height.equalTo(25)
            make.centerX.equalToSuperview()
        }
        minmaxLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherTextLabel.snp.bottom).offset(5)
            make.height.equalTo(25)
            make.centerX.equalToSuperview()
        }
    }
    override func configureUI(){

    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
