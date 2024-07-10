//
//  Reusable.swift
//  CityWeatherApp
//
//  Created by 심소영 on 7/11/24.
//

import UIKit

protocol Reusable {
    static var id: String { get }
}

extension UITableViewCell: Reusable {
    static var id: String {
       return String(describing: self)
    }
}

extension UICollectionViewCell: Reusable {
    static var id: String {
       return String(describing: self)
    }
}
