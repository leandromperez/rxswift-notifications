//
//  NoParamNotificable.swift
//  Notifications
//
//  Created by Leandro Perez on 11/24/18.
//  Copyright © 2018 Leandro perez. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public protocol NoParamNotifiable : NotificationObservable {
    func post()
    func addListener(handler: @escaping () -> Void) -> Disposable
    func addListener(handler: @escaping (Notification) -> Void) -> Disposable
    func addListener<A:AnyObject>(weak obj:A, handler: @escaping (A) -> () -> Void) -> Disposable
}

public extension NoParamNotifiable {

    func post() {
        NotificationCenter.default.post(name: self.notificationName, object: nil, userInfo: nil)
    }

    func addListener(handler: @escaping () -> Void) -> Disposable {
        return self.notificationObservable()
            .subscribe(onNext: { (_) in
                handler()
            })
    }

    func addListener(handler: @escaping (Notification) -> Void) -> Disposable {
        return self.notificationObservable()
            .subscribe(onNext: { notification in
                handler(notification)
            })
    }

    func addListener<A:AnyObject>(weak obj:A, handler: @escaping (A) -> () -> Void) -> Disposable {
        return self.addListener { [weak obj] in
            guard let obj = obj else {return}

            handler(obj)()
        }
    }
}

extension NSNotification.Name : NoParamNotifiable {
    public var notificationName : Notification.Name {
        return self
    }
}
