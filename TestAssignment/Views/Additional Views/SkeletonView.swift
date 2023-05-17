import SwiftUI

// Skeleton View for better UX
struct SkeletonView: View {
    var body: some View {
        List(0...15,id: \.self) { i in
            if i == 0 {
                ShimmerEffectBoxView()
                    .cornerRadius(15)
                    .frame(width: 70, height: 20, alignment: .leading)
                    .listRowSeparator(.hidden)
                    .padding(.leading, -6)
            }
            ShimmerEffectBoxView()
                .frame(height: 80)
                .cornerRadius(15)
                .padding(EdgeInsets(top: -12, leading: -2.8, bottom: 5, trailing: -2.8))
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct SkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        SkeletonView()
    }
}
