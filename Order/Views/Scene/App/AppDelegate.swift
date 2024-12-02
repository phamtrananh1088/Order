//
//  AppDelegate.swift
//  Order
//
//  Created by anh on 2024/11/25.
//

import Foundation
import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NotificationService.shared.center.delegate = self
//        Task {
//            await NotificationService.shared.requestAuthorization()
//        }
//        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
//        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        return true
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.content.categoryIdentifier == "MEETING_INVITATION" {
            print("Meeting invitation is queued for delivery")
            completionHandler([.sound])
            return
        } else {
            print("Notification is resolved")
        }
        completionHandler(UNNotificationPresentationOptions(rawValue: 0))
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.content.categoryIdentifier == "MEETING_INVITATION" {
            switch response.actionIdentifier {
            case "ACCEPT_ACTION":
                print("Meeting invitation is accepted")
                break
            case "DECLINE_ACTION":
                print("Meeting invitation is declined")
                break
            case UNNotificationDefaultActionIdentifier, UNNotificationDismissActionIdentifier:
                print("Meeting invitation is queued for delivery")
            default:
                break
            }
        } else {
            print("Notification received: \(response.notification.request.content)")
            
        }
        completionHandler()
    }
//    @objc func deviceOrientationDidChange() {
//        let orientation = UIDevice.current.orientation
//        
//    }
}
