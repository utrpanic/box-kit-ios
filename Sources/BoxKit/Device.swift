//
//  Device.swift
//  BoxKit
//
//  Created by box-jeon on 2020/01/23.
//

import UIKit

public struct Device {
    
    public static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    public static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public static var isLandscape: Bool {
        if #available(macCatalyst 13.0, *) {
            guard let window = UIApplication.shared.delegate?.window else { return false }
            guard let width = window?.frame.width else { return false }
            guard let height = window?.frame.height else { return false }
            return width > height
        } else {
            // 바닥에 내려놓은 경우 .faceUp
            // 누워서 들고 있는 경우 .faceDown
            // isLandscape이 false임.
            switch UIDevice.current.orientation {
            case .portrait, .portraitUpsideDown:
                return false
            case .landscapeLeft, .landscapeRight:
                return true
            default:
                return UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
    }
    
    public static var currentStatusBarHeight: CGFloat {
        if #available(iOS 13.0, macCatalyst 13.0, *) {
            return UIApplication.shared.delegate?.window??.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    public static var safeAreaInsets: UIEdgeInsets {
        return UIApplication.shared.delegate?.window??.safeAreaInsets ?? .zero
    }
    
    public static var singlePixel: CGFloat {
        return 1.0 / UIScreen.main.scale
    }
}
