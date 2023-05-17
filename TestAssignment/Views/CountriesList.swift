import SwiftUI

struct CountriesList: View {
    
    @EnvironmentObject private var routerManager: NavigationRouter
    @StateObject var networkMonitor = NetworkMonitor()
    @StateObject private var manager = NotificationManager()
    @StateObject private var vm = CountriesListViewModel()

    var body: some View {
        NavigationStack(path:$routerManager.routes) {
            Group {
                if vm.loaded {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack {
                            ForEach(vm.sortedContinents, id: \.self) { continent in
                                ContinentHeaderView(continentName: continent)
                                ForEach(vm.continents[continent] ?? [], id: \.self) { item in
                                    RowView(country: item)
                                }
                                .cornerRadius(15)
                                .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
                            }
                        }
                    }
                } else {
                    SkeletonView()
                }
            }
            .navigationDestination(for: Route.self, destination: { route in
                switch route{
                    case .Country(let country):
                        CountryDetails(country: country)
                    }
                }
            )
            .navigationTitle("World Countries")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task(
            {
                await manager.getAuthStatus()
            }
        )
        .onAppear {
            vm.applyAppearance()
            Task {
                await manager.request()
            }
            if networkMonitor.isActive {
                vm.loadData()
            }
        }
        .onChange(of: networkMonitor.isActive) { newValue in
            if newValue && files.shared.countries.isEmpty {
                vm.loadData()
            }
        }
        .onChange(of: vm.loaded) { _ in
            if manager.hasPermision {
                manager.scheduleNotifications(country: files.shared.randomCountry)
            }
        }
        // these methods are needed to adapt the screen for iPads
        .navigationViewStyle(StackNavigationViewStyle())
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}
struct CountriesList_Previews: PreviewProvider {
    static var previews: some View {
        CountriesList()
            .environmentObject(NavigationRouter())
    }
}
