import Foundation

struct Country: Codable, Hashable {
    let maps: [String: String]?
    let name: Name?
    let cca2: String?
    let currencies: [String: Currency]?
    let capital: [String]?
    let population: Int?
    let timezones: [String]?
    let region: String?
    let area: Double?
    let continents: [String]?
    let latlng: [Double]?
    let flags: Flag?
}
struct Flag: Codable {
    let png: String?
    let svg: String?
    let alt: String?
}
struct Name: Codable {
    let common: String?
    let official: String?
}
struct Currency: Codable {
    let name: String?
    let symbol: String?
}

extension Country {
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.area == rhs.area
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(area)
    }
}
