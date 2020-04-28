//
//  NotificationsListener.swift
//  Notifications
//
//  Created by Leandro Perez on 11/24/18.
//  Copyright © 2018 Leandro perez. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

public protocol NotificationsListener {
    func listenToNotification(named name:Notification.Name, do handler:@escaping (Notification) -> Void ) -> Disposable

    func listenTo<T:NoParamNotifiable>( notification : T, do handler: @escaping () -> Void )  -> Disposable
    func listenTo<T:NoParamNotifiable>( notification : T, do handler: @escaping (Notification) -> Void ) -> Disposable

    func listenTo<T:Notifiable>( notification : T, do handler: @escaping () -> Void ) -> Disposable
    func listenTo<T:Notifiable>( notification : T, do handler: @escaping (T.ParameterType) -> Void )  -> Disposable
    func listenTo<T:Notifiable>( notification : T, do handler: @escaping (T.ParameterType, Notification) -> Void )  -> Disposable
}

public extension NotificationsListener {

    func listenToNotification(named name:Notification.Name, do handler:@escaping (Notification) -> Void ) -> Disposable {
        return NotificationCenter.default.rx
            .notification(name)
            .subscribe(onNext: handler)
    }

    func listenTo<T:NoParamNotifiable>( notification : T, do handler: @escaping(Notification) -> Void ) -> Disposable {
        return notification.addListener(handler: handler)
    }

    func listenTo<T:NoParamNotifiable>( notification : T, do handler: @escaping () -> Void )  -> Disposable {
        return notification.addListener(handler: handler)
    }

    func listenTo<T:Notifiable>( notification : T, do handler: @escaping () -> Void ) -> Disposable {
        return notification.addListener{ _ in handler() }
    }

    func listenTo<T:Notifiable>( notification : T, do handler: @escaping (T.ParameterType) -> Void )  -> Disposable {
        return notification.addListener(handler: handler)
    }

    func listenTo<T:Notifiable>( notification : T, do handler: @escaping (T.ParameterType, Notification) -> Void )  -> Disposable {
        return notification.addListener(handler: handler)
    }
}

extension UIViewController : NotificationsListener {}

