//
//  DetailView.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import UIKit
import SnapKit
import Kingfisher
 
final class DetailView: BaseView {
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.tintColor = .darkGray
        return image
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subscriptLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    init(frame: CGRect, systemName: String, typeText: String) {
        super.init(frame: frame)
        iconImage.image = UIImage(systemName: systemName)
        typeLabel.text = typeText
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func configureUI() {
        backgroundColor = UIColor(hexCode: "334660", alpha: 0.8)
        layer.cornerRadius = 10
    }
    override func configureLayout() {
        iconImage.snp.makeConstraints { make in
            make.leading.equalTo(self).inset(10)
            make.top.equalTo(self).offset(10)
            make.size.equalTo(20)
        }
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(iconImage.snp.trailing).offset(5)
            make.height.equalTo(20)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(self).inset(10)
            make.height.equalTo(30)
        }
        subscriptLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(10)
            make.horizontalEdges.equalTo(self).inset(10)
            make.height.equalTo(60)
        }
    }
    override func configureHierarchy() {
        addSubview(iconImage)
        addSubview(typeLabel)
        addSubview(resultLabel)
        addSubview(subscriptLabel)
    }
    func setText(numResult: String, subLabel: String, iconImageResult: String, cityResult: String ) {
        let url = URL(string: iconImageResult)
        iconImage.kf.setImage(with: url)
        resultLabel.text = numResult
        subscriptLabel.text = subLabel
    }
}
