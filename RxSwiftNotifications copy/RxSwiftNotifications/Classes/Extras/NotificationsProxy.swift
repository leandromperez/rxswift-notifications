//
//  NotificationsProxy.swift
//  Notifications
//
//  Created by Leandro Perez on 11/24/18.
//  Copyright © 2018 Leandro perez. All rights reserved.
//

import Foundation
import RxSwift

open class NotificationsProxy<Subject> {
    private let disposeBag = DisposeBag()
    public var subject : Subject

    public init(subject: Subject) {
        self.subject = subject

        self.listenToNotifications()
    }

    open func listenToNotifications() {
        assertionFailure("override in subclasses")
    }

    public func listenTo<T:NoParamNotifiable>( notification : T, do handler: @escaping(inout Subject, Notification) -> Void ) {
        notification.addListener { [unowned self] (notification) in
            handler(&self.subject, notification)
        }
        .disposed(by: self.disposeBag)
    }

    public func listenTo<T:NoParamNotifiable>( notification : T, do handler: @escaping(inout Subject) -> Void ) {
        notification
            .addListener { [unowned self] in
                handler(&self.subject)
        }
        .disposed(by: self.disposeBag)
    }

    public func listenTo<T:Notifiable>( notification : T, do handler: @escaping(inout Subject) -> Void ) {
        notification
            .addListener { [unowned self]  (_) in
                handler(&self.subject)
        }
        .disposed(by: self.disposeBag)
    }

    public func listenTo<T:Notifiable>( notification : T, do handler: @escaping(inout Subject) -> (T.ParameterType) -> Void ) {
        notification
            .addListener { [unowned self]  (parameter: T.ParameterType) in
                handler(&self.subject)(parameter)
        }
        .disposed(by: self.disposeBag)
    }

    public func listenTo<T:Notifiable>( notification : T, do handler: @escaping(inout Subject, T.ParameterType) -> Void ) {
        notification
            .addListener { [unowned self]  (parameter: T.ParameterType) in
                handler(&self.subject, parameter)
        }
        .disposed(by: self.disposeBag)
    }
}
