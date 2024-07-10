//
//  SectionView.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import UIKit
import SnapKit

final class SectionView: BaseView {
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        image.image = UIImage(systemName: "calendar")
        return image
    }()
    
    init(frame: CGRect, text: String) {
        super.init(frame: frame)
        textLabel.text = text
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func configureUI() {
        
    }
    override func configureLayout() {
        iconImage.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
            make.size.equalTo(30)
        }
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(iconImage.snp.trailing).offset(10)
            make.height.equalTo(30)
        }
    }
    override func configureHierarchy() {
        addSubview(iconImage)
        addSubview(textLabel)
    }
}
