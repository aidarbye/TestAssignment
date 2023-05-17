import SwiftUI

struct CountryDetails: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm: CountryDetailsViewModel
    
    init(country: Country) {
        _vm = StateObject(wrappedValue: CountryDetailsViewModel(country: country))
    }
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: -2) {
                if let image = vm.image {
                    image
                        .resizable()
                        .frame(height: 200)
                        .cornerRadius(15)
                        .overlay(Color.black.opacity(0.09))
                        .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .padding()
                }
                CellView(text: "Region", subtext: vm.country.region?.capitalized ?? "")
                CellView(text: "Capital", subtext: vm.country.capital?.first ?? "No info")
                Link(destination: ((.init(string: vm.country.maps?["openStreetMaps"] ?? "") ?? URL(fileURLWithPath: "")))) {
                    CellView(text: "Capital coordinates",
                             subtext:
                                String.latlng(first: vm.country.latlng?.first, last: vm.country.latlng?.last))
                        .foregroundColor(.black)
                }
                CellView(text: "Population", subtext: "\(vm.country.population ?? 0) people")
                CellView(text: "Area", subtext: "\(String(format: "%.1f",vm.country.area ?? 0)) km²")
                CellView(text: "Currency", subtext: "\(String.Currency(dict: vm.country.currencies))"
                )
                CellView(text: "Timezones", subtext: String.timezone(times: vm.country.timezones))
            }
        }
        .navigationTitle(vm.country.name?.common ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss()} ) {
                    Image(systemName: "chevron.left")
                        .fontWeight(.medium)
                }
            }
        }
    }
}

struct CountryDetails_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetails(country: Country(maps: nil,
                                        name: Name(common: "Heard Island and McDonald Islands", official: "KZ"),
                                        cca2: "AS",
                                        currencies: ["KZT":Currency(name: "Tenge", symbol: "T")],
                                        capital: ["Astana"],
                                        population: 2,
                                        timezones: ["6 TMZ"],
                                        region: "ASIA",
                                        area: 20312,
                                        continents: ["ASIA"],
                                        latlng: [12.21,22.42],
                                        flags: Flag(png: "https://flagcdn.com/w320/kz.png", svg: "", alt: "")))
    }
}
