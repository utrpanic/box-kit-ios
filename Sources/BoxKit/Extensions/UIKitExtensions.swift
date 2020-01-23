//
//  UIKitExtensions.swift
//  BoxKit
//
//  Created by box.jeon on 2020/01/23.
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
        return String(format: "%02x%02x%02x", Int(red * 255), Int(green * 255), Int(blue * 255))
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

extension UIImage {
    
    public var original: UIImage { return self.withRenderingMode(.alwaysOriginal) }
    public var template: UIImage { return self.withRenderingMode(.alwaysTemplate) }
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

extension UIView {
    
    public func addSubviewAsMatchParent(_ view: UIView) {
        self.addSubview(view)
        let leading = self.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let top = self.topAnchor.constraint(equalTo: view.topAnchor)
        let trailing = self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottom = self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([leading, top, trailing, bottom])
    }
    
    public func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
            
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    public func addTopLine(color: UIColor, height: CGFloat = 0.5) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        if let superview = self.superview {
            superview.addSubview(view)
            let bottomSpace = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            let leading = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
            let trailing = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
            let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: height)
            NSLayoutConstraint.activate([bottomSpace, leading, trailing, height])
        }
    }
    
    public func addBottomLine(color: UIColor, height: CGFloat = 0.5) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        if let superview = self.superview {
            superview.addSubview(view)
            let topSpace = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            let leading = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
            let trailing = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
            let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: height)
            NSLayoutConstraint.activate([topSpace, leading, trailing, height])
        }
    }
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: frame, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

