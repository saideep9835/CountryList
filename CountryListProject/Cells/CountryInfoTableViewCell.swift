//
//  CountryInfoTableViewCell.swift
//  CountryListProject
//
//  Created by Saideep Reddy Talusani on 4/23/25.
//


import UIKit

final class CountryInfoTableViewCell: UITableViewCell {
    
    private let nameAndRegionLabel = UILabel()
    private let codeLabel = UILabel()
    private let capitalLabel = UILabel()
    
    private let horizontalTopStack = UIStackView()
    private let verticalMainStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [nameAndRegionLabel, codeLabel, capitalLabel].forEach {
            $0.numberOfLines = 0
        }

        // Top horizontal stack: Name + Code
        horizontalTopStack.axis = .horizontal
        horizontalTopStack.spacing = 8
        horizontalTopStack.distribution = .fillProportionally
        horizontalTopStack.translatesAutoresizingMaskIntoConstraints = false
        
        nameAndRegionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        codeLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        horizontalTopStack.addArrangedSubview(nameAndRegionLabel)
        horizontalTopStack.addArrangedSubview(codeLabel)

        // Main vertical stack
        verticalMainStack.axis = .vertical
        verticalMainStack.spacing = 8
        verticalMainStack.translatesAutoresizingMaskIntoConstraints = false
        
        verticalMainStack.addArrangedSubview(horizontalTopStack)
        verticalMainStack.addArrangedSubview(capitalLabel)
        
        contentView.addSubview(verticalMainStack)
        
        NSLayoutConstraint.activate([
            verticalMainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            verticalMainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            verticalMainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            verticalMainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configureCell(nameAndRegion: String, code: String, capital: String) {
        nameAndRegionLabel.text = nameAndRegion
        codeLabel.text = code
        capitalLabel.text = capital
    }
    
    static var reuseIdentifier: String {
        String(describing: self)
    }

    static func register(in tableView: UITableView) {
        tableView.register(CountryInfoTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}
