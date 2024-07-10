//
//  MainCollectionViewCell.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import UIKit
import SnapKit

final class MainCollectionViewCell: BaseCollectionViewCell {
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.text = "12시"
        return label
    }()
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "star")
        return image
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.text = "5°"
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
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.leading.equalTo(timeLabel.snp.leading)
            make.centerX.equalToSuperview()
            make.size.equalTo(50)
        }
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(20)
            make.leading.equalTo(iconImage.snp.leading)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    override func configureView() {
        backgroundColor = .clear
    }
}
