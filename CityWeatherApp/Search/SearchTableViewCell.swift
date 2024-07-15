//
//  SearchTableViewCell.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/15/24.
//

import UIKit
import SnapKit

class SearchTableViewCell: BaseTableViewCell {
    
    private lazy var ImageLabel: UILabel = {
       let label = UILabel()
        label.text = "#"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    private lazy var countryLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .left
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    override func configureView() {
        backgroundColor = .clear
    }
    override func configureLayout() {
        ImageLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.size.equalTo(30)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(ImageLabel.snp.trailing).offset(10)
            make.height.equalTo(20)
        }
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(ImageLabel.snp.trailing).offset(10)
            make.height.equalTo(20)
        }
    }
    override func configureHierarchy() {
        contentView.addSubview(ImageLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countryLabel)
    }
    func setText(name: String, country: String) {
        nameLabel.text = name
        countryLabel.text = country
    }
}
