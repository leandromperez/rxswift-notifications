//
//  Town.swift
//  NotificationsTests
//
//  Created by Leandro Perez on 11/24/18.
//  Copyright © 2018 Leandro perez. All rights reserved.
//

import Foundation
import RxSwiftNotifications
import RxSwift

struct Person {
    let name : String
}

extension Person : Equatable {}
func == (lhs: Person, rhs:Person)  -> Bool {
    return lhs.name == rhs.name
}


enum TimeNotification : String, NoParamNotifiable {
    case newYear
}

class Town {
    var deadPeople : [Person] = []
    var alivePeople : [Person] = []
    let disposeBag = DisposeBag()
    var year = 2000

    init() {
        PersonNotification.personDied
            .addListener { [unowned self] (person) in
                self.personDied(person)
            }
            .disposed(by: disposeBag)

        PersonNotification.personWasBorn
            .addListener { [unowned self] (person) in
                self.personWasBorn(person)
            }
            .disposed(by: disposeBag)

        TimeNotification.newYear
            .addListener { [unowned self] (person) in
                self.year += 1
            }
            .disposed(by: disposeBag)
    }

    func personDied(_ person: Person) {
        alivePeople.removeAll(where: {$0 == person})
        deadPeople += [person]
    }

    func personWasBorn(_ person: Person) {
        alivePeople += [person]
    }

    var report : String {
        return "alive: \(self.alivePeople.map{$0.name}), dead: \(self.deadPeople.map{$0.name})"
    }
}
