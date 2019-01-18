//
//  GenNotificationTests.swift
//  NotificationsTests
//
//  Created by Leandro Perez on 12/26/18.
//  Copyright © 2018 Leandro perez. All rights reserved.
//

import XCTest
import RxSwiftNotifications
import RxSwift

class GenNotificationTests: XCTestCase {

    func testObservable() {
        let disposeBag = DisposeBag()

        var received = ""

        MixedTypesNotifications.stringNotification
            .asObservable()
            .subscribe(onNext: { (value) in
                received = value
            })
            .disposed(by: disposeBag)

        MixedTypesNotifications.stringNotification.post(parameter: "something")

        XCTAssertEqual(received, "something")
    }
}

enum MixedTypesNotifications : String, Notifiable {
    typealias ParameterType = Int

    case standardIntNotification

    static let stringNotification: GenNotification<String> = GenNotification(id: "stringNotification")
}
