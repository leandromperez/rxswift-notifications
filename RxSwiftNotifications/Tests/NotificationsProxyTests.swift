//
//  NotificationsProxyTests.swift
//  NotificationsTests
//
//  Created by Leandro Perez on 12/26/18.
//  Copyright © 2018 Leandro perez. All rights reserved.
//

import XCTest
import RxSwiftNotifications
import RxSwift

class NotificationsProxyTests: XCTestCase {

    var library : Library!
    var listener : ListenerForLibrary!

    override func setUp() {
        super.setUp()
        library = Library()
        listener =  ListenerForLibrary(subject: library)
    }

    func testListenTo() {
        BookNotifications.bookWasWritten.post()

        XCTAssertEqual(library.booksCount, 1)
    }

    func testListenToWithParameter() {
        BookNotifications.bookWasWrittenWithTitle.post(parameter: "Title")

        XCTAssertEqual(library.booksCount, 1)
        XCTAssertEqual(library.lastTitle, "Title")
    }

}

class ListenerForLibrary : NotificationsProxy<Library> {
    override func listenToNotifications() {
        self.listenTo(notification: BookNotifications.bookWasWritten) { (library) in
            library.booksCount += 1
        }

        self.listenTo(notification: BookNotifications.bookWasWrittenWithTitle) { (library, title) in
            library.booksCount += 1
            library.lastTitle = title
        }
    }
}

class Library {
    var booksCount = 0
    var lastTitle = ""
}

enum BookNotifications : String, NoParamNotifiable {
    case bookWasWritten
    static var bookWasWrittenWithTitle = GenNotification<String>(id: "bookWasWritten")
}
