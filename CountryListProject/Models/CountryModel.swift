//
//  CountryModel.swift
//  CountryListProject
//
//  Created by Saideep Reddy Talusani on 4/18/25.
//


import Foundation

struct CountryModel: Codable, Equatable {
    let capital: String
    let code: String
    let currency: Currency
    let name: String
    let region: String
}

struct Currency: Codable, Equatable {
    let code: String
    let name: String
}
