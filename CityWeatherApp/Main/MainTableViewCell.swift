//
//  MainTableViewCell.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import UIKit
import SnapKit
import Kingfisher

final class MainTableViewCell: BaseTableViewCell {
    let viewModel = WeatherModel()
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .right
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
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
        iconImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(dayLabel.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(70)
        }
        minTempLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(iconImage.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
        maxTempLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
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
    func configureTimeCell(data: String) {
        guard let dataForecast = viewModel.outputForecastData.value?.list.first(where: { $0.dt_txt == data }) else {
            return
        }
        
        if let dayOfWeek = hourFormatter.dayOfWeek(from: dataForecast.dt_txt) {
            dayLabel.text = dayOfWeek
        } else {
            dayLabel.text = nil
        }
    }

    func setText(icon: String) {
        if let url = URL(string: icon) {
            iconImage.kf.setImage(with: url)
        }
    }

    func configureForecastCell(data: WeatherList?){
        let tempMax = (data?.main.temp_max ?? 0) - 273.15
        let tempMin = (data?.main.temp_min ?? 0) - 273.15
        let min = String(format: "최저 %.0f°", tempMin)
        let max = String(format: "최고 %.0f°", tempMax)
        if let date = data?.dt_txt, let dayWeek = hourFormatter.dayOfWeek(from: date){
            dayLabel.text = dayWeek
            minTempLabel.text = min
            maxTempLabel.text = max
        } else {
            dayLabel.text = nil
        }
    }
}
