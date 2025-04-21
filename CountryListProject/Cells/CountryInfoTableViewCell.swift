//
//  CountryInfoTableViewCell.swift
//  CountryListProject
//
//  Created by Saideep Reddy Talusani on 4/18/25.
//


import UIKit

final class CountryInfoTableViewCell: UITableViewCell {
    private lazy var nameAndRegionLabel: UILabel = {
        return createStandardLabel(fontSize: 17, fontWeight: .regular, textAlignment: .natural)
    }()
    
    private lazy var codeLabel: UILabel = {
        return createStandardLabel(fontSize: 17, fontWeight: .regular, textAlignment: .natural)
    }()
    
    private lazy var capitalLabel: UILabel = {
        return createStandardLabel(fontSize: 17, fontWeight: .regular, textAlignment: .natural)
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabels() {
        contentView.addSubview(nameAndRegionLabel)
        contentView.addSubview(codeLabel)
        contentView.addSubview(capitalLabel)
        
        constrainLabels()
    }
    
    private func createStandardLabel(fontSize: CGFloat, fontWeight: UIFont.Weight, textAlignment: NSTextAlignment) -> UILabel {
        let targetLabel = UILabel()
        targetLabel.textAlignment = textAlignment
        targetLabel.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        targetLabel.numberOfLines = .zero
        targetLabel.translatesAutoresizingMaskIntoConstraints = false
        return targetLabel
    }
    
    private func constrainLabels() {
        NSLayoutConstraint.activate([
            nameAndRegionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameAndRegionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameAndRegionLabel.trailingAnchor.constraint(equalTo: codeLabel.leadingAnchor, constant: -10),
            codeLabel.topAnchor.constraint(equalTo: nameAndRegionLabel.topAnchor),
            codeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            codeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            capitalLabel.topAnchor.constraint(equalTo: nameAndRegionLabel.bottomAnchor, constant: 10),
            capitalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            capitalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            capitalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

extension CountryInfoTableViewCell {
    func configureCell(nameAndRegion: String, code: String, capital: String) {
        nameAndRegionLabel.text = nameAndRegion
        codeLabel.text = code
        capitalLabel.text = capital
    }
}
