//
//  Device.swift
//  BoxJeonExtension
//
//  Created by BoxJeon on 07/04/2019.
//  Copyright © 2019 boxjeon. All rights reserved.
//

import UIKit

public struct Device {
    
    public static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    public static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    public static var safeAreaTopInset: CGFloat {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0
    }
    
    public static var safeAreaBottomInset: CGFloat {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
    }
}

