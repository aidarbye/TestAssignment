import Foundation
import SwiftUI

// Class for working with data in all workspace
final class files: ObservableObject {
    static let shared = files()
    @Published var countries: [Country] = []
    @Published var randomCountry: Country?
}

final class CountriesListViewModel: ObservableObject {
    @Published var continents: [String: [Country]] = [:]
    @Published var loaded = false
    var sortedContinents: [String] {
        return self.continents.keys.sorted { $0 < $1 }
    }
    func loadData() {
        NetworkManager.shared.fetchData(from: api) { [self] country in
            files.shared.countries = country
            files.shared.randomCountry = country.randomElement() ?? nil
            for country in files.shared.countries {
                for continent in country.continents ?? [] {
                    if continents[continent] == nil {
                        continents[continent] = [country]
                    } else {
                        continents[continent]?.append(country)
                    }
                }
            }
            loaded.toggle()
        }
    }
    // Setting up UINavBar
    func applyAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97,alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
