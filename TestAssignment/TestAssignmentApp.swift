import SwiftUI
import UserNotifications

@main
struct TestAssignmentApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: MyAppDelegate
    @StateObject private var routerManager = NavigationRouter()
    var body: some Scene {
        WindowGroup {
            CountriesList()
                .preferredColorScheme(.light)
                .environmentObject(routerManager)
                .onAppear {
                    appDelegate.app = self
                }
        }
    }
}
extension TestAssignmentApp {
    // In order to catch notifications that contain a deeplink
    func handleDeeplinking(from url: URL) async {
        let routeFinder = RouteFinder()
        if let route = await routeFinder.find(from: url) {
            routerManager.pust(to: route)
        }
    }
}

