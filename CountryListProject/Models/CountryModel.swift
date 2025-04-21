import Foundation

struct CountryModel: Codable {
    let capital: String
    let code: String
    let currency: Currency
    let name: String
    let region: String
}

struct Currency: Codable {
    let code: String
    let name: String
}
