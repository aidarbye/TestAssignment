import SwiftUI
// ShimmerView for using and SkeletonView
struct ShimmerEffectBoxView: View {
    private var gradientColors = [
        Color.init(red: 242/255, green: 242/255, blue: 242/255),
        Color.init(red: 250/255, green: 250/255, blue: 250/255),
        Color.init(red: 242/255, green: 242/255, blue: 242/255)
    ]
    @State var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    
    var body: some View {
        HStack {
            LinearGradient(colors: gradientColors,
                           startPoint: startPoint,
                           endPoint: endPoint)
            .onAppear {
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: false)) {
                    startPoint = .init(x: 1, y: 1)
                    endPoint = .init(x: 2.2, y: 2.2)
                }
            }
        }
    }
}

struct ShimmerEffectBoxView_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerEffectBoxView()
    }
}
