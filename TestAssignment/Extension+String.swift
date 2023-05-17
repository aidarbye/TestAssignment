import Foundation
// Methods for work with string
extension String {
    static func Currency(dict: [String:Currency]?) -> String{
        var result:[String] = []
        dict?.forEach { key, currency in
            if let name = currency.name, let symbol = currency.symbol {
                result.append("\(name) (\(symbol)) (\(key))")
            }
        }
        return result.joined(separator: "\n")
    }
    static func latlng(first: Double?, last: Double?) -> String {
        "\(String(first ?? 0).replacingOccurrences(of: ".", with: "°"))', \(String(last ?? 0).replacingOccurrences(of: ".", with: "°"))'"
    }
    static func timezone(times: [String]?) -> String {
        return times?.joined(separator: "\n") ?? ""
    }
}
