//
//  MainCollectionViewCell.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import UIKit
import SnapKit
import Kingfisher

final class MainCollectionViewCell: BaseCollectionViewCell {
    let viewModel = WeatherModel()
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func configureHierarchy() {
        addSubview(timeLabel)
        addSubview(iconImage)
        addSubview(tempLabel)
    }
    override func configureLayout() {
        timeLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        iconImage.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.leading.equalTo(timeLabel.snp.leading)
            make.centerX.equalToSuperview()
            make.size.equalTo(60)
        }
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(10)
            make.leading.equalTo(iconImage.snp.leading)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    override func configureView() {
        backgroundColor = .clear
    }
    func setText(icon: String) {
        let url = URL(string: icon)
        iconImage.kf.setImage(with: url)
    }
    func configureWeatherCell(data: Weather?){
        
    }
    func configureForecastCell(data: WeatherList?){
        guard let hour = hourFormatter.hourFormatter(dateString: data?.dt_txt ?? "") else {return}
        timeLabel.text = hour
        let temp = (data?.main.temp ?? 0) - 273.15
        let tempFormat = String(format: "%.0f°", temp)
        tempLabel.text = tempFormat
    }
}
