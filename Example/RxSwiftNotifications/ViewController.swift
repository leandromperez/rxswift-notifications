//
//  ViewController.swift
//  RxSwiftNotifications
//
//  Created by leandromperez@gmail.com on 01/05/2019.
//  Copyright (c) 2019 leandromperez@gmail.com. All rights reserved.
//

import UIKit
import RxSwiftNotifications
import RxSwift

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        //Example of a standard notification listener. Checkout the tests for more examples
        UIApplication.didBecomeActiveNotification
            .addListener {
                print("App did become active")
            }
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

