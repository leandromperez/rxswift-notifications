//
//  NotificationObservable.swift
//  Notifications
//
//  Created by Leandro Perez on 11/24/18.
//  Copyright © 2018 Leandro perez. All rights reserved.
//

import Foundation
import RxSwift

public protocol NotificationObservable {
    var identifier: String {get}
    var notificationName : Notification.Name {get}
    func notificationObservable() -> Observable<Notification>
}

public extension NotificationObservable {
    var notificationName : Notification.Name {
        return Notification.Name(self.identifier)
    }
    
    func notificationObservable() -> Observable<Notification> {
        return NotificationCenter.default.rx.notification(self.notificationName)
    }
}

public extension NotificationObservable where Self : RawRepresentable, Self.RawValue == String {
    var identifier: String {
        return "\(type(of: self))" + self.rawValue
    }
}
