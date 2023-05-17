import Foundation
import UserNotifications

// The class responsible for working with notifications
@MainActor
class NotificationManager: ObservableObject {
    @Published private(set) var hasPermision = false
    init() { Task { await getAuthStatus() } }
    func request() async {
        do {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound])
        } catch {
            print(error.localizedDescription)
        }
    }
    // get status 
    func getAuthStatus() async {
        let status = await UNUserNotificationCenter.current().notificationSettings()
        switch status.authorizationStatus {
        case .authorized,.provisional,.ephemeral: hasPermision = true
        default: hasPermision = false
        }
    }
    // notification 3 seconds after starting with deeplink
    func scheduleNotifications(country: Country?) {
        let content = UNMutableNotificationContent()
        content.title = country?.name?.common ?? "No info"
        content.body = country?.capital?.first ?? "No info"
        content.sound = .default
        let userInfo = ["link": "myapp://random"]
        content.userInfo = userInfo
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: "repeatingNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Repeating notification scheduled successfully")
            }
        }
    }
}
