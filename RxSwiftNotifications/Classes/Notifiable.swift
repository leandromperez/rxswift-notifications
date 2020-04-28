//
//  Notificable.swift
//  Notifications
//
//  Created by Leandro Perez on 11/24/18.
//  Copyright © 2018 Leandro perez. All rights reserved.
//

import Foundation
import RxSwift

public protocol Notifiable : NotificationObservable {
    associatedtype ParameterType
    
    func post(parameter:ParameterType)
    func asObservable() -> Observable<ParameterType>
}

public extension Notifiable {

    func post(parameter: ParameterType) {
        let userInfo  : [AnyHashable: Any]? = [self.identifier : parameter]
        NotificationCenter.default.post(name: self.notificationName, object: nil, userInfo: userInfo)
    }

    func asObservable() -> Observable<ParameterType> {
        return self.notificationObservable()
            .map{
                guard let parameter = $0.userInfo?[self.identifier] as? ParameterType
                    else {fatalError("The notification must have the right parameter")}
                return parameter
        }
    }
}


