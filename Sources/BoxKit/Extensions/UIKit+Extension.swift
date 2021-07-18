//
//  UIKit+Extension.swift
//  BoxKit
//
//  Created by box-jeon on 2020/01/23.
//

import UIKit
import AVFoundation

extension UICollectionView {
    
    public func registerFromClass<T: UICollectionViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: T.typeName)
    }
    
    public func registerFromNib<T: UICollectionViewCell>(_ cellClass: T.Type) where T: NibLoadable {
        self.register(UINib(nibName: T.typeName, bundle: nil), forCellWithReuseIdentifier: T.typeName)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return (self.dequeueReusableCell(withReuseIdentifier: T.typeName, for: indexPath) as? T)!
    }
}

extension UIColor {
    
    public var hex: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return String(format: "#%02x%02x%02x", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
    
    public convenience init?(hex: String?, alpha: CGFloat = 1) {
        guard let hex = hex?.replacingOccurrences(of: "#", with: ""), hex.count == 6 else {
            return nil
        }
        var rgb: UInt64 = 0
        let scanner = Scanner(string: hex)
        scanner.scanHexInt64(&rgb)
        self.init(red: CGFloat((rgb & 0xff0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00ff00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000ff) / 255.0, alpha: alpha)
    }
}

extension UIDevice {
    public var isPhone: Bool { self.userInterfaceIdiom == .phone }
    public var isPad: Bool { self.userInterfaceIdiom == .pad }
}

extension UIImage {
    
    public var original: UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
    
    public var template: UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
}

extension UITableView {
    
    public func registerFromClass<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) {
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: T.typeName)
    }
    
    public func registerFromNib<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) where T: NibLoadable {
        self.register(UINib(nibName: T.typeName, bundle: nil), forHeaderFooterViewReuseIdentifier: T.typeName)
    }
    
    public func dequeueReusableView<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) -> T {
        return (self.dequeueReusableHeaderFooterView(withIdentifier: T.typeName) as? T)!
    }
    
    public func registerFromClass<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: T.typeName)
    }
    
    public func registerFromNib<T: UITableViewCell>(_ cellClass: T.Type) where T: NibLoadable {
        self.register(UINib(nibName: T.typeName, bundle: nil), forCellReuseIdentifier: T.typeName)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return (self.dequeueReusableCell(withIdentifier: T.typeName, for: indexPath) as? T)!
    }
}
