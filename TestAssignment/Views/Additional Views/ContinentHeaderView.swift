import SwiftUI
// Header for continents
struct ContinentHeaderView: View {
    let continentName: String
    var body: some View {
        Text(continentName)
            .font(.headline)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 15)
            .padding(.top, 10)
            .tracking(1.5)
    }
}
