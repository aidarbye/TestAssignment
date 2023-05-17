import UserNotifications
import SwiftUI

// AppDelegate for work with deeplinks and notifications
class MyAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    var app: TestAssignmentApp?
    @StateObject private var routerManager = NavigationRouter.shared
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}
extension MyAppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        if let deepLink = response.notification.request.content.userInfo["link"] as? String, let url = URL(string: deepLink) {
            Task {
                await app?.handleDeeplinking(from: url)
            }
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound,.badge,.banner,.list]
    }
}
