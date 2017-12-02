//
//  BoxJeonUIExtension.swift
//  BoxJeonExtension
//
//  Created by boxjeon on 2017. 10. 21..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

public protocol HasClassNameId: class {
    
    static var id: String { get }
}

public extension HasClassNameId {
    
    static var id: String { return NSStringFromClass(self).components(separatedBy: ".").last! }
}

public protocol NibLoadable: HasClassNameId {
    
}

public extension NibLoadable where Self: UIView {
    
    public static func create() -> Self? {
        let bundle = Bundle(for: self)
        let views = bundle.loadNibNamed(self.id, owner: nil, options: nil)
        for index in 0 ..< (views?.count ?? 0) {
            if let view = views?[index] as? Self {
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }
        }
        return nil
    }
}

public extension NibLoadable where Self: UIViewController {
    
    public static func create(storyboardName: String) -> Self? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: self.id) as? Self
    }
}

public extension UICollectionView {
    
    public func registerNib<T: UICollectionViewCell>(_ cellClass: T.Type) where T: NibLoadable {
        self.register(UINib(nibName: T.id, bundle: nil), forCellWithReuseIdentifier: T.id)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T where T: NibLoadable {
        return self.dequeueReusableCell(withReuseIdentifier: T.id, for: indexPath) as! T
    }
}

public extension UIColor {
    
    public var hex: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return String(format: "%02x%02x%02x", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
    
    public convenience init?(hex: String?) {
        guard let hex = hex?.replacingOccurrences(of: "#", with: ""), hex.length == 6 else {
            return nil
        }
        var rgb: UInt32 = 0
        let scanner = Scanner(string: hex)
        scanner.scanHexInt32(&rgb)
        self.init(red: CGFloat((rgb & 0xff0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00ff00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000ff) / 255.0, alpha: 1)
    }
}

public extension UIImage {
    
    public var original: UIImage { return self.withRenderingMode(.alwaysOriginal) }
    public var template: UIImage { return self.withRenderingMode(.alwaysTemplate) }
}

public extension UITableView {
    
    public func registerNib<T: UITableViewCell>(_ cellClass: T.Type) where T: NibLoadable {
        self.register(UINib(nibName: T.id, bundle: nil), forCellReuseIdentifier: T.id)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T where T: NibLoadable {
        return self.dequeueReusableCell(withIdentifier: T.id, for: indexPath) as! T
    }
}

public extension UIView {
    
    public func addSubviewAsMatchParent(_ view: UIView) {
        self.addSubview(view)
        let leading = view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        let trailing = view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        let top = view.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        let bottom = view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
}
