//
//  WeatherDetailViewController.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/10/24.
//

import UIKit
import SnapKit

final class WeatherDetailViewController: BaseViewController {
    
    private let scrollView = UIScrollView()
    private let locationMainView = MainLocationView()
    private let tableView = UITableView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private let collectionSectionLabel = SectionView(frame: .zero, text: "3시간 간격의 일기예보")
    private let TableViewSectionLabel = SectionView(frame: .zero, text: "5일 간의 일기예보")

    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 150)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func configureView() {
        super.configureView()
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = UIColor(hexCode: "334660", alpha: 0.8)
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = UIColor(hexCode: "334660", alpha: 0.8)
        view.backgroundColor = UIColor(hexCode: "253348", alpha: 1.0)
    }
    override func configureHierarchy() {
        view.addSubview(locationMainView)
        view.addSubview(collectionView)
        view.addSubview(collectionSectionLabel)
        view.addSubview(TableViewSectionLabel)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
        tableView.rowHeight = 60
    }
    override func configureConstraints() {
        locationMainView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        collectionSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(locationMainView.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(30)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(collectionSectionLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(160)
        }
        TableViewSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(TableViewSectionLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(300)
        }
    }
}

extension WeatherDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as! MainCollectionViewCell
        return cell
    }
}

extension WeatherDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.id, for: indexPath) as! MainTableViewCell
        return cell
    }
   
}
