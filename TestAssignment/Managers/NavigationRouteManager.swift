import Foundation

// Everything here is responsible for the navigation, the navigation stack
enum Route: Hashable {
    case Country(country: Country)
}

enum DeepLinkURLs: String {
    case random = "random"
}

final class NavigationRouter: ObservableObject {
    static let shared = NavigationRouter()
    @Published var routes = [Route]()
    func pust(to screen: Route) {
        routes.append(screen)
    }
}

struct RouteFinder {
    func find(from url: URL) async -> Route? {
        guard let host = url.host() else { return nil }
        switch DeepLinkURLs(rawValue: host) {
        case .random:
            if let randomCountry = files.shared.randomCountry {
                return .Country(country: randomCountry)
            } else {
                return nil
            }
        default:
            return nil
        }
    }
}
