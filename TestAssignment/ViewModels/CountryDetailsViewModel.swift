import Foundation
import SwiftUI

class CountryDetailsViewModel: ObservableObject {
    @Published var country: Country
    @Published var image: Image?
    
    init(country: Country) {
        self.country = country
        loadImage()
    }
    
    private func loadImage() {
        guard let imageURL = URL(string: (country.flags?.png)!) else {
            image = Image(systemName: "picture")
            return
        }
        // Checking for cached content
        if let cachedImage = NetworkManager.shared.getCacheImage(from: imageURL) {
            image = Image(uiImage: cachedImage)
            return
        }
        // Uploading an image from the network
        NetworkManager.shared.fetchImageData(from: imageURL) { (data, response) in
            DispatchQueue.main.async {
                if let uiimage = UIImage(data: data) {
                    self.image = Image(uiImage: uiimage)
                } else {
                    return
                }
            }
            // Save to cash
            NetworkManager.shared.saveDataToCache(with: data, response: response)
        }
    }
}

