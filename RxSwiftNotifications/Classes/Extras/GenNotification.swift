//
//  GenNotification.swift
//  Notifications
//
//  Created by Leandro Perez on 11/24/18.
//  Copyright © 2018 Leandro perez. All rights reserved.
//

import Foundation
import RxSwift

public struct GenNotification<T> : Notifiable {

    public typealias ParameterType = T

    private(set) public var identifier : String

    public init (id:String) {
        self.identifier = id
    }

    public func asObservableNotification() -> Observable<Notification> {
        return NotificationCenter.default.rx.notification(self.notificationName)
    }
}
