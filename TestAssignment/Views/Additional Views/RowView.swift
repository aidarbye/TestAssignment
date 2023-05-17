
import SwiftUI

struct RowView: View {
    
    @StateObject private var vm: RowViewViewModel
    
    init(country: Country) {
        _vm = StateObject(wrappedValue: RowViewViewModel(country: country))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
                HStack {
                    if let image = vm.image {
                        image
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 80,height: 50)
                    } else {
                        Image(systemName: "photo")
                            .frame(width: 80, height: 50)
                            .cornerRadius(10)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text(vm.country.name?.common ?? "nil")
                            .fontWeight(.bold)
                        Text(vm.country.capital?.first! ?? "Null")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button {
                        withAnimation(.default) {
                            vm.ison.toggle()
                        }
                    } label: {
                        Image(systemName: vm.ison ? "chevron.up" : "chevron.down")
                            .clipShape(Circle())
                            .font(.system(size: 24))
                    }.foregroundColor(.gray)
                }
                if vm.ison {
                    Group {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Population:")
                                    .foregroundColor(.gray)
                                Text("\(vm.country.population ?? 0)")
                            }
                            HStack {
                                Text("Area:")
                                    .foregroundColor(.gray)
                                Text("\(String(format:"%.1f",vm.country.area ?? 0)) km²")
                            }
                            HStack {
                                Text("Currencies:")
                                    .foregroundColor(.gray)
                                Text(String.Currency(dict: vm.country.currencies))
                            }
                        }
                        HStack(alignment: .center) {
                            Spacer()
                            NavigationLink(value: Route.Country(country:vm.country)) {
                                Text("Learn more")
                                    .fontWeight(.medium)
                            }
                            Spacer()
                        }.frame(height: 50)
                    }
                }
            }
        .padding()
        .background(Color.init(red: 248/255, green: 248/255, blue: 248/255))
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(country: Country(maps: nil,
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
