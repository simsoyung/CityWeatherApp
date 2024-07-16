//
//  WeatherDetailViewController.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/10/24.
//

import UIKit
import SnapKit
import MapKit

final class WeatherDetailViewController: BaseViewController {
    
    var locationData: ((DummyData) -> Void)?
    let viewModel = WeatherModel()
    let toolBar = UIToolbar()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let locationMainView = MainLocationView()
    private let tableView = UITableView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private let collectionSectionLabel = SectionView(frame: .zero, text: "3시간 간격의 일기예보")
    private let tableViewSectionLabel = SectionView(frame: .zero, text: "5일 간의 일기예보")
    private let wind = DetailView(frame: .zero, systemName: "star.fill", typeText: "바람 속도")
    private let cloud = DetailView(frame: .zero, systemName: "star", typeText: "구름")
    private let pressure = DetailView(frame: .zero, systemName: "wind", typeText: "기압")
    private let humidity = DetailView(frame: .zero, systemName: "cloud.rain", typeText: "습도")
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 140)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        
        // print(realm.configuration.fileURL)
    }
    override func viewDidAppear(_ animated: Bool) {
        locationData = { [ weak self ] data in
            self?.viewModel.inputCellLonLat.value = data
            self?.tableView.reloadData()
        }
    }
    override func configureView() {
        super.configureView()
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 10
        collectionView.backgroundColor = UIColor(hexCode: "334660", alpha: 0.8)
        tableView.backgroundColor = UIColor(hexCode: "334660", alpha: 0.8)
        view.backgroundColor = UIColor(hexCode: "253348", alpha: 1.0)
        navigationController?.isToolbarHidden = false
        setupToolbarItems()
    }
    override func configureHierarchy() {
        view.addSubview(toolBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(locationMainView)
        contentView.addSubview(collectionView)
        contentView.addSubview(collectionSectionLabel)
        contentView.addSubview(tableViewSectionLabel)
        contentView.addSubview(mapView)
        contentView.addSubview(wind)
        contentView.addSubview(cloud)
        contentView.addSubview(pressure)
        contentView.addSubview(humidity)
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
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        locationMainView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(240)
        }
        collectionSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(locationMainView.snp.bottom)
            make.horizontalEdges.equalTo(contentView).offset(10)
            make.height.equalTo(30)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(collectionSectionLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(160)
        }
        tableViewSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(30)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tableViewSectionLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(300)
        }
        mapView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(300)
        }
        wind.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(20)
            make.size.equalTo(170)
        }
        cloud.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.trailing.equalTo(contentView).inset(20)
            make.size.equalTo(170)
        }
        pressure.snp.makeConstraints { make in
            make.top.equalTo(wind.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(20)
            make.size.equalTo(170)
            make.bottom.equalTo(contentView)
        }
        humidity.snp.makeConstraints { make in
            make.top.equalTo(cloud.snp.bottom).offset(20)
            make.trailing.equalTo(contentView).inset(20)
            make.size.equalTo(170)
            make.bottom.equalTo(contentView)
        }
    }
    
    func bindData(){
        viewModel.location.startUpdatingLocation()
        viewModel.inputViewDidLoadTrigger.value = (nil)
       // viewModel.
        viewModel.outputForecastData.bind {[ weak self ] weather in
            self?.setData()
        }
        viewModel.onDataChanged = {
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
    }
    func setData(){
        guard let data = viewModel.outputForecastData.value else {return}
        let temp = data.list[0].main.temp - 273.15
        let tempFormat = String(format: "%.1f°", temp)
        let tempMax = data.list[0].main.temp_max - 273.15
        let tempMin = data.list[0].main.temp_min - 273.15
        let minmax = String(format: "최고: %.1f° | 최저: %.1f°", tempMax, tempMin)
        locationMainView.setText(location: data.city.name, temp: tempFormat, weatherResult: data.list[0].weather[0].description, minMaxTemp: minmax)
        wind.setText(mainDetail: "\(viewModel.outputWeatherData.value?.wind.speed ?? 0)" ,subDetail: "m/s 바람이 불어요")
        cloud.setText(mainDetail: "\(viewModel.outputWeatherData.value?.clouds.all ?? 0)" ,subDetail: "%만큼 구름이 꼈어요")
        let pressureText = viewModel.outputWeatherData.value?.main.pressure
        pressure.setText(mainDetail: hourFormatter.numFormatNumber(number: pressureText ?? 0),subDetail: "hPa")
        humidity.setText(mainDetail: "\(viewModel.outputWeatherData.value?.main.humidity ?? 0)" ,subDetail: "% 만큼 습해요")
    }
    func setupToolbarItems() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let mapButton = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(mapTapped))
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(searchTapped))
        let barItems = [mapButton, flexibleSpace, searchButton]
        toolbarItems = barItems
    }
    @objc func mapTapped() {
        print("map button tapped")
    }
    
    @objc func searchTapped() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension WeatherDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputForecastData.value?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as! MainCollectionViewCell
        //let dataWeather = viewModel.outputWeatherData.value?.weather[indexPath.item]
        let dataForecast = viewModel.outputForecastData.value?.list[indexPath.item]
        //cell.configureWeatherCell(data: dataWeather)
        cell.configureForecastCell(data: dataForecast)
        if let icon = viewModel.outputIconurl?[indexPath.item] {
            cell.setText(icon: icon)
        }
        return cell
    }
}

extension WeatherDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredForecastMaxData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.id, for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        //let dataWeather = viewModel.outputWeatherData.value?.weather[indexPath.row]
        let dataForecastMax = viewModel.filteredForecastMaxData[indexPath.row]
        let dataForecastMin = viewModel.filteredForecastMinData[indexPath.row]
        //cell.configureWeatherCell(data: dataWeather)
        cell.configureForecastCell(data: dataForecastMax)
        cell.configureForecastCellMin(data: dataForecastMin)
        if let icons = dataForecastMax.weather.first?.icon { //하나씩 빼서 배열에 담음
            print(icons," ========  넘긴 icons")
            cell.setText(icon: icons)
        }
        return cell
        
    }
   
}
