import Foundation

final class CountryDisplayViewModel {
    private let networkClient: any NetworkClientProtocol
    
    private(set) var countries: [CountryModel] = []
    private(set) var filteredCountries: [CountryModel] = []

    init(networkClient: any NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchCountries() async throws {
        let countries = try await networkClient.genericFetch(endPoint: Constants.EndPoints.fetchCountriesURL, parseType: [CountryModel].self)
        self.countries = countries
    }
    
    func getCountry(index: Int) -> CountryModel {
        return countries[index]
    }
    
    func getCountriesCount() -> Int {
        return countries.count
    }
    
    func generateNameAndRegion(country: CountryModel) -> String {
        return "\(country.name), \(country.region)"
    }
    
    func generateCode(country: CountryModel) -> String {
        return "\(country.code)"
    }
    
    func generateCapital(country: CountryModel) -> String {
        return country.capital
    }
}

extension CountryDisplayViewModel {
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
}
