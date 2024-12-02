//
//  NotificationService.swift
//  Order
//
//  Created by anh on 2024/11/25.
//

import Foundation
import UserNotifications
import UIKit

class NotificationService {
    let center = UNUserNotificationCenter.current()
    static let shared = NotificationService()
    private init(){
        
    }
    
    func requestAuthorization() async -> Bool {
        do {
            return try await center.requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            print(error)
            return false
        }
    }
    
    func scheduleLocalNotification(title: String, body: String) async {
        let settings = await center.notificationSettings()
        guard settings.authorizationStatus == .authorized else {return}
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = nil
        
        var dateComponents = DateComponents()
        dateComponents.calendar = System.getCaldendar()
        let c = System.getCurrentTime()
        dateComponents.year = c.year
        dateComponents.month = c.month
        dateComponents.day = c.day
        dateComponents.hour = c.hour
        dateComponents.minute = c.minute
        dateComponents.second = c.second + 30
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        do {
            try await center.add(request)
            print("schedule a user notification locally ")
        } catch {
            print(error)
        }
    }
    
    func scheduleMeetingLocalNotification() async {
        let settings = await center.notificationSettings()
        guard settings.authorizationStatus == .authorized else {return}
        
        let meetingInviteCategory = createMeetingNotificationCategory()
        center.setNotificationCategories([meetingInviteCategory])
        
        let content = UNMutableNotificationContent()
        content.title = "Meeting Invitation"
        content.body = "You have a new meeting invitation"
        content.userInfo = ["MEETING_ID": UUID().uuidString, "USER_ID": Config.pref.lastUser ?? ""]
        content.categoryIdentifier = "MEETING_INVITATION"
        content.sound = .default
        content.badge =  await NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        do {
            try await center.add(request)
            print("schedule a meeting invitation ")
        } catch {
            print(error)
        }
    }
    
    func clearPendingNotifications() {
        center.removeAllPendingNotificationRequests()
    }
    
    func clearDeliveredNotifications() {
        center.removeAllDeliveredNotifications()
    }
    
    func createMeetingNotificationCategory() -> UNNotificationCategory {
        let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION", title: "Accept", options: [])
        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION", title: "Decline", options: [])
        let meetingInviteCategory = UNNotificationCategory(identifier: "MEETING_INVITATION", actions: [acceptAction, declineAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
        return meetingInviteCategory
    }
}
