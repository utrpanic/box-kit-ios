import Foundation
import UIKit

public protocol HasClassName: class {}

extension HasClassName {
    
    public static var className: String { return String(describing: self) }
}

extension UIView: HasClassName {}

extension UIViewController: HasClassName {}

public protocol NibLoadable {}

extension NibLoadable where Self: UIView {
    
    public static func createFromNib() -> Self? {
        let bundle = Bundle(for: self)
        let views = bundle.loadNibNamed(self.className, owner: nil, options: nil)
        for index in 0 ..< (views?.count ?? 0) {
            if let view = views?[index] as? Self {
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }
        }
        return nil
    }
}

extension UICollectionView {
    
    public func registeFromClass<T: UICollectionViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: T.className)
    }
    
    public func registerFromNib<T: UICollectionViewCell>(_ cellClass: T.Type) where T: NibLoadable {
        self.register(UINib(nibName: T.className, bundle: nil), forCellWithReuseIdentifier: T.className)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
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
    
    public convenience init?(hex: String?) {
        guard let hex = hex?.replacingOccurrences(of: "#", with: ""), hex.count == 6 else {
            return nil
        }
        var rgb: UInt32 = 0
        let scanner = Scanner(string: hex)
        scanner.scanHexInt32(&rgb)
        self.init(red: CGFloat((rgb & 0xff0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00ff00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000ff) / 255.0, alpha: 1)
    }
}

extension UIImage {
    
    public var original: UIImage { return self.withRenderingMode(.alwaysOriginal) }
    public var template: UIImage { return self.withRenderingMode(.alwaysTemplate) }
}

extension UITableView {
    
    public func registerFromClass<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) {
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: T.className)
    }
    
    public func registerFromNib<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) where T: NibLoadable {
        self.register(UINib(nibName: T.className, bundle: nil), forHeaderFooterViewReuseIdentifier: T.className)
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.className) as! T
    }
    
    public func registerFromClass<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: T.className)
    }
    
    public func registerFromNib<T: UITableViewCell>(_ cellClass: T.Type) where T: NibLoadable {
        self.register(UINib(nibName: T.className, bundle: nil), forCellReuseIdentifier: T.className)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }
}
