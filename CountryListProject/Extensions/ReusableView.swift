//
//  ReusableView.swift
//  CountryListProject
//
//  Created by Saideep Reddy Talusani on 4/23/25.
//


import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView { }

extension ReusableView where Self: UITableViewCell {
    static func register(in tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: Self.reuseIdentifier)
    }
}
