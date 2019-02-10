# RxSwiftNotifications

[![Build Status](https://travis-ci.org/leandromperez/rxswift-notifications.svg?branch=master)](https://travis-ci.org/leandromperez/rxswift-notifications)
[![Version](https://img.shields.io/cocoapods/v/RxSwiftNotifications.svg?style=flat)](https://cocoapods.org/pods/RxSwiftNotifications)
[![License](https://img.shields.io/cocoapods/l/RxSwiftNotifications.svg?style=flat)](https://cocoapods.org/pods/RxSwiftNotifications)
[![Platform](https://img.shields.io/cocoapods/p/RxSwiftNotifications.svg?style=flat)](https://cocoapods.org/pods/RxSwiftNotifications)

## Introduction
This project contains some extensions on top of NSNotificationCenter that allows the creation of strong-typed notifications. My goal was to have a type-safe, reactive and easier-to-use mechanism. 

## How to use them?

### 1. Declare the notification type

Create a **struct, enum**, or **class**, that will represent the notification using the type system. :

```swift
enum UserNotification : String, Notifiable {
    typealias ParameterType = User

    case userDidLogin
    case userDidLogout
}
```
### 1. Subscribe to the notification

 Subscribe to the notification and use the parameter directly. 
 
 ⚠️ Notice that this is **type safe**, you don’t need to extract the parameter and cast it! 
The extensions will safely do that.

#### Option 1:  Add a listener to the notification

```swift
    UserNotification.userDidLogin
        .addListener { [unowned self] (user: User) in
            self.loadPreferences(of: user) 
        }
        .disposed(by: disposeBag)
```

#### Option 2: You can also treat the notification like a regular Observable:
 
 ```swift
    UserNotification.userDidLogin.asObservable()
        .subscribe(onNext:{ [unowned self] (user:User) in
            self.loadPreferences(of: user)
        })    
        .disposed(by: disposeBag)
 ```
 ## Notifications with no parameters.
 NoParamsNotifiable, lets you post notifications with no parameters:
 ```swift

    enum CalendarNotification : NoParamsNotifiable {
        case calendarDidSynchronize
    }
 
    CalendarNotification.caledarDidSynchronize
        .addListener{     
            print("Calendar synchronized")
        }
        .disposed(by:disposeBag)
 ```

## Test cases

To run the example project, clone the repo, and run `pod install` from the Example directory first.
It contains a set of unit tests that explain how to use other features.

## Requirements

## Installation

RxSwiftNotifications is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxSwiftNotifications'
```

## Author

Leandro Perez, leandromperez@gmail.com

## License

RxSwiftNotifications is available under the MIT license. See the LICENSE file for more info.
