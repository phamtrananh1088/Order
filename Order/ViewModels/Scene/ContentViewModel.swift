//
//  EnvironmentViewModel.swift
//  Order
//
//  Created by anh on 2024/11/23.
//

import Foundation
import UIKit


class ContentViewModel: ObservableObject, Identifiable {
    @Published var screenName: ScreenName = .contentView
    @Published var id: String  = UUID().uuidString
    @Published var isLogouted: Bool = false
   
    init() {
        addObservers()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func reset() {
        id = UUID().uuidString
        screenName = .contentView
        isLogouted = false
       
//        NotificationCenter.default.removeObserver(self)
//        addObservers()
    }
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.receiveNotification(notification:)), name: Notification.Name(NotificationName.loggedOut.rawValue), object: nil)
        
    }
    @objc private func receiveNotification(notification: Notification) {
        switch notification.name.rawValue {
        case NotificationName.loggedOut.rawValue:
            isLogouted = true
            break
        default:
            break
        }
    }
}

class KeyboardResponder: ObservableObject {
    @Published var isShow: Bool = false
    var keyboardSize: CGRect? = nil
    init() {
        addObservers()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
   
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            isShow = true
            self.keyboardSize = keyboardSize
        }
    }
    @objc private func keyboardWillHide(notification: NSNotification) {
        isShow = false
        self.keyboardSize = nil
    }
}

enum NotificationName: String {
    case loggedOut = "loggedOut"
}
