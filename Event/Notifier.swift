//
//  Notifications.swift
//  SainsburysPay
//
//  Created by Furio Catalano on 05/04/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import UIKit

enum SainsburysPayNotification: String {
    case moveToWalkthrough
    case moveToLogin
    case moveToHome
    case moveToRegistration
    case moveToAddNectarCardFromRegistration
    case moveToAddNectarCardFromHome
    case moveToApp
}

class Notifier {
    func post(_ notification: SainsburysPayNotification, sender: AnyObject? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification.rawValue), object: sender)
    }

    func register(_ notification: SainsburysPayNotification, observer: AnyObject, selector: Selector, object: AnyObject? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: notification.rawValue), object: object)
    }
}
