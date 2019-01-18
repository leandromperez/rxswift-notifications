//
//  NoParamNotifiableTests.swift
//  NotificationsTests
//
//  Created by Leandro Perez on 12/3/18.
//  Copyright © 2018 Leandro perez. All rights reserved.
//

import XCTest
import RxSwiftNotifications
import RxSwift

class NoParamNotifiableTests: XCTestCase {

    func testObservable() {
        let disposeBag = DisposeBag()

        var notificationsCount = 0

        NoParamsNotifications.somethingDidHappen
            .notificationObservable()
            .subscribe(onNext: { (notification) in
                notificationsCount += 1
            })
            .disposed(by: disposeBag)

        NoParamsNotifications.somethingDidHappen.post()

        XCTAssertEqual(notificationsCount, 1)
    }

    func testAddListener() {
        let disposeBag = DisposeBag()

        var notificationsCount = 0

        NoParamsNotifications.somethingDidHappen
            .addListener {
                notificationsCount += 1
            }
            .disposed(by: disposeBag)

        NoParamsNotifications.somethingDidHappen.post()

        XCTAssertEqual(notificationsCount, 1)
    }


    func testAddListenerWithNotification() {
        let disposeBag = DisposeBag()

        var receivedNotification : Notification?
        NoParamsNotifications.somethingDidHappen
            .addListener { (notification) in
                receivedNotification = notification
            }
            .disposed(by: disposeBag)

        NoParamsNotifications.somethingDidHappen.post()


        XCTAssertNotNil(receivedNotification)
    }

    func testAddListenerWithWeakHandler() {
        let disposeBag = DisposeBag()

        let counter = Counter()

        NoParamsNotifications.somethingDidHappen
            .addListener(weak: counter, handler: Counter.increase)
            .disposed(by: disposeBag)

        NoParamsNotifications.somethingDidHappen.post()

        XCTAssertEqual(counter.count, 1)
    }

    

}

enum NoParamsNotifications : String, NoParamNotifiable {

    case somethingDidHappen
}


class Counter {
    var count = 0
    func increase() {
        count += 1
    }
}
