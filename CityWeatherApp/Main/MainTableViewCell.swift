//
//  MainTableViewCell.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import UIKit
import SnapKit

final class MainTableViewCell: BaseTableViewCell {
    let viewModel = WeatherModel()
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textAlignment = .left
        label.text = "오늘"
        return label
    }()
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "star")
        return image
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textAlignment = .left
        label.text = "최저 5°"
        return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textAlignment = .right
        label.text = "최고 5°"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    override func configureView() {
        backgroundColor = .clear
    }
    override func configureLayout() {
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
        iconImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(dayLabel.snp.trailing).offset(40)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
        minTempLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(iconImage.snp.trailing).offset(30)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
        maxTempLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    override func configureHierarchy() {
        addSubview(dayLabel)
        addSubview(iconImage)
        addSubview(minTempLabel)
        addSubview(maxTempLabel)
    }
    func configureWeatherCell(data: Weather?){
        
    }
    func configureForecastCell(data: WeatherList?){
        
    }
}
