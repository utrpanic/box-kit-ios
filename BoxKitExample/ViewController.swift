//
//  ViewController.swift
//  BoxKitExample
//
//  Created by BoxJeon on 2019/08/10.
//  Copyright © 2019 utrpanic. All rights reserved.
//

import UIKit
import BoxKit

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("statusBarHeight: \(Device.safeAreaTopInset)")
    }
}
