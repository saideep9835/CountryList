//
//  CountryDisplayViewModel.swift
//  CountryListProject
//
//  Created by Saideep Reddy Talusani on 4/23/25.
//


import Foundation

@MainActor
final class CountryDisplayViewModel {
    private let networkClient: any NetworkClientProtocol
    
    private(set) var countries: [CountryModel] = []
    private(set) var filteredCountries: [CountryModel] = []

    init(networkClient: any NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchCountries() async throws {
        let countries = try await networkClient.genericFetch(
            endPoint: Constants.EndPoints.fetchCountriesURL,
            parseType: [CountryModel].self
        )
        self.countries = countries
    }

    func filterCountriesBySearchText(searchBarText: String) {
        guard !searchBarText.isEmpty else {
            ErrorLogger.logError("Empty search text detected.")
            return
        }
        
        self.filteredCountries = self.countries.filter {
            $0.name.lowercased().contains(searchBarText.lowercased()) ||
            $0.capital.uppercased().contains(searchBarText.uppercased())
        }
    }

    func getCountry(index: Int) -> CountryModel {
        countries[index]
    }
    
    func getCountriesCount() -> Int {
        countries.count
    }
    
    func generateNameAndRegion(country: CountryModel) -> String {
        "\(country.name), \(country.region)"
    }
    
    func generateCode(country: CountryModel) -> String {
        "\(country.code)"
    }
    
    func generateCapital(country: CountryModel) -> String {
        country.capital
    }
}
