//
//  SearchViewController.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/10/24.
//

import UIKit
import SnapKit

final class SearchViewController: BaseViewController {
    
    let viewModel = SearchViewModel()
    let tableView = UITableView()
    let searchBar = UISearchBar()
    var filteredData: [DummyData] = []
    
    var clousre: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputViewDidLoadTrigger.value = ()
        bindData()
    }
    
    override func configureView() {
        super.configureView()
        tableView.backgroundColor = .clear
        view.backgroundColor = UIColor(hexCode: "253348", alpha: 1.0)
        setSearchBar()
    }
    override func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        tableView.rowHeight = 70
        searchBar.delegate = self
    }
    override func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func bindData(){
        viewModel.outputData.bind{ [ weak self ] _ in
            self?.filteredData = self?.viewModel.outputData.value ?? []
            self?.tableView.reloadData()
        }
    }
    private func setSearchBar(){
        searchBar.backgroundImage = UIImage()
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.backgroundColor = UIColor(hexCode: "425C85", alpha: 1.0)
            searchTextField.textColor = .white
            searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for a city.",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
            imageView.tintColor = .lightGray
            searchTextField.leftView = imageView
            searchTextField.leftViewMode = .always
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as! SearchTableViewCell
        cell.selectionStyle = .none
        let data = filteredData[indexPath.row]
        cell.setText(name: data.name, country: data.country)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.outputData.value[indexPath.row]
        //이전뷰가 WeatherDetailViewController가 맞다면! 데이터보내
        if let vc = navigationController?.viewControllers.dropLast().last as? WeatherDetailViewController {
            vc.locationData?(data)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredData = viewModel.outputData.value
            //tableView.reloadData()
            return
        }
        let lowercasedSearchText = searchText.lowercased()
        filteredData = viewModel.outputData.value.filter { data in
            data.name.lowercased().contains(lowercasedSearchText)
        }
        //tableView.reloadData()
    }
}

