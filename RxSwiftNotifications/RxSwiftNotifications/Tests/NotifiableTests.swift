//
//  NotificationsTests.swift
//  NotificationsTests
//
//  Created by Leandro Perez on 11/24/18.
//  Copyright © 2018 Leandro perez. All rights reserved.
//

import XCTest
import RxSwiftNotifications
import RxSwift

class NotifiableTests: XCTestCase {

    let john = Person(name:"John")

    func testNotificationObservable() {
        let disposeBag = DisposeBag()

        var notificationsCount = 0

        PersonNotification.personDied
            .notificationObservable()
            .subscribe(onNext: { (notification) in
                notificationsCount += 1
            })
            .disposed(by: disposeBag)

        PersonNotification.personDied.post(parameter: john)

        XCTAssertEqual(notificationsCount, 1)
    }

    func testAsObservable() {
        let disposeBag = DisposeBag()

        var deadPerson : Person?

        PersonNotification.personDied
            .asObservable()
            .subscribe(onNext: { (newDead) in
                deadPerson = newDead
            }).disposed(by: disposeBag)

        PersonNotification.personDied.post(parameter: john)

        XCTAssertEqual(deadPerson, john)
    }

    func testAddListener() {
        let disposeBag = DisposeBag()

        var deadPerson : Person?

        PersonNotification.personDied
            .addListener { deadPerson = $0 }
            .disposed(by: disposeBag)

        PersonNotification.personDied.post(parameter: john)

        XCTAssertEqual(deadPerson, john)
    }

    func testAddListenerDisposeBag() {
        var disposeBag = DisposeBag()

        var deadPerson : Person?

        PersonNotification.personDied
            .addListener { deadPerson = $0 }
            .disposed(by: disposeBag)

        disposeBag = DisposeBag()

        PersonNotification.personDied.post(parameter: john)

        XCTAssertEqual(deadPerson, nil)
    }

}

enum PersonNotification : String, Notifiable {

    typealias ParameterType = Person

    case personWasBorn
    case personDied
}

