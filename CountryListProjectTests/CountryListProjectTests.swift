//
//  CountryListProjectTests.swift
//  CountryListProjectTests
//
//  Created by Saideep Reddy Talusani on 4/18/25.
//

import XCTest
@testable import CountryListProject

final class CountryListProjectTests: XCTestCase {

    private var mockCountryDisplayViewModel: CountryDisplayViewModel?
    private var mockNetworkClient: any NetworkClientProtocol = MockNetworkClient()
    
    static let countriesCollection: [CountryModel] = [CountryModel(capital: "Tirana", code: "AL", currency: Currency(code: "ALL", name: "Albanian lek"), name: "Albania", region: "EU"), CountryModel(capital: "Pago Pago", code: "AS", currency: Currency(code: "USD", name: "United States Dollar"), name: "American Samoa", region: "OC")]
    
    @MainActor override func setUpWithError() throws {
        super.setUp()
        mockCountryDisplayViewModel = CountryDisplayViewModel(networkClient: mockNetworkClient)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        mockCountryDisplayViewModel = nil
    }
    
    @MainActor func testFetchCountries() async {
        let expectation = expectation(description: "Expecting successful fetch of countries' information.")
        Task {
            do {
                try await mockCountryDisplayViewModel?.fetchCountries()
                XCTAssertEqual(mockCountryDisplayViewModel?.countries, Self.countriesCollection)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    @MainActor func testGenerateCapital() {
        let targetCountry = Self.countriesCollection[0]
        
        let capitalOutput = mockCountryDisplayViewModel?.generateCapital(country: targetCountry)
        XCTAssertEqual(capitalOutput, targetCountry.capital)
    }
    
    @MainActor func testGenerateCode() {
        let targetCountry = Self.countriesCollection[1]
        let codeOuput = mockCountryDisplayViewModel?.generateCode(country: targetCountry)
        XCTAssertEqual(codeOuput, targetCountry.code)
    }
    
    @MainActor func testGenerateNameAndRegion() {
        let targetCountry = Self.countriesCollection[0]
        let expectedRegion = targetCountry.region
        let expectedCountryName = targetCountry.name
        
        let nameAndRegionOutput = mockCountryDisplayViewModel?.generateNameAndRegion(country: targetCountry)
        
        XCTAssertEqual(nameAndRegionOutput, "\(expectedCountryName), \(expectedRegion)")
    }
    
    @MainActor func testFilterCountriesBySearchText() {
        let searchText = "Po"
        mockCountryDisplayViewModel?.filterCountriesBySearchText(searchBarText: searchText)
        let qualifyingCountries = mockCountryDisplayViewModel?.filteredCountries
        
        XCTAssertEqual(qualifyingCountries?.count, 0)
    }
}

fileprivate class MockNetworkClient: NetworkClientProtocol {
    typealias NetworkErrors = NetworkClient.NetworkErrors
    
    func genericFetch<T>(endPoint: String, parseType: T.Type) async throws -> T where T: Decodable, T: Encodable {
        try await Task.sleep(nanoseconds: 2000_000_000)
        
        guard let countriesCollection = CountryListProjectTests.countriesCollection as? T else {
            throw NetworkErrors.invalidData
        }
        return countriesCollection
    }
}
