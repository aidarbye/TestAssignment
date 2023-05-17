import Foundation
import Network
import SwiftUI

// The class responsible for handling data loading
class NetworkManager {
    static let shared = NetworkManager()
    // The method responsible for data fetching,cache.
    func fetchData(from url: String?,with competition: @escaping ([Country])->Void) {
        guard let stringUrl = url, let url = URL(string: stringUrl) else {return}
//         if let cachedData = getCachedData(from: url) {
//             if let countries = try? JSONDecoder().decode([Country].self, from: cachedData) {
//                 DispatchQueue.main.async {
//                     competition(countries)
//                 }
//                 return
//             }
//         }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {return}
            do {
                let country = try JSONDecoder().decode([Country].self, from: data)
                DispatchQueue.main.async {
                    competition(country)
//                     self.saveDataToCache(with: data, response: response)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    // Save Data to Cache
    func saveDataToCache(with data: Data, response: URLResponse?) {
        guard let response = response else { return }
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
    // Get Cached Data
//     func getCachedData(from url: URL) -> Data? {
//         let urlRequest = URLRequest(url: url)
//         if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
//             return cachedResponse.data
//         }
//         return nil
//     }
    // Fetch Image for next steps
    func fetchImageData(from url: URL, with competition: @escaping (Data,URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response , error) in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard url == response.url else { return }
            competition(data,response)
        }.resume()
    }
    // Get Image Cache
    func getCacheImage(from url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}

// The class responsible for working with the connection to the Internet
class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    @Published var isActive = true
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isActive = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
}
