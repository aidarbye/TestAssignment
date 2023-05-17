import SwiftUI
// Cell for CountryDetails
struct CellView: View {
    let text: String
    let subtext: String
    var body: some View {
        HStack(spacing: 18) {
            Circle()
                .frame(width: 10)
                .offset(y:-10)
            VStack(alignment: .leading,spacing: 5) {
                Text(text+":")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(subtext)
                    .font(.title2)
            }
            Spacer()
        }.padding()
    }
}

