//
//  BoxJeonExtension.swift
//  BoxJeonExtension
//
//  Created by boxjeon on 2017. 10. 21..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

protocol NibLoadable: class {
    
    static var id: String { get }
    
}

extension NibLoadable {
    
    static var id: String { return NSStringFromClass(self).components(separatedBy: ".").last! }
    
}

extension NibLoadable where Self: UIView {
    
    static func create() -> Self? {
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

extension NibLoadable where Self: UIViewController {
    
    static func create(storyboardName: String) -> Self? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: self.id) as? Self
    }
    
}

extension String {
    
    var urlEncoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    var urlDecoded: String? {
        return self.removingPercentEncoding
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var length: Int {
        return self.utf16.count
    }
    
    func substring(to: Int) -> String {
        guard 0 <= to else { return "" }
        guard to < self.length else { return self }
        return String(Substring(self.utf16.prefix(to)))
    }
    
    func substring(from: Int) -> String {
        guard 0 <= from else { return self }
        guard from < self.length else { return "" }
        return String(Substring(self.utf16.suffix(self.length - from)))
    }
    
    func substring(from: Int, to: Int) -> String {
        return self.substring(to: to).substring(from: from)
    }
    
    func localized(_ args: CVarArg...) -> String {
        let format = NSLocalizedString(self, comment: "")
        if args.count == 0 {
            return format
        } else {
            return String(format: format, arguments: args)
        }
    }
    
}

extension UICollectionView {
    
    func registerNib(id: String) {
        self.register(UINib(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.id, for: indexPath) as! T
    }
    
}

extension UIColor {
    
    convenience init?(hex: String?) {
        guard let hex = hex?.replacingOccurrences(of: "#", with: ""), hex.length == 6 else {
            return nil
        }
        var rgb: UInt32 = 0
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1
        scanner.scanHexInt32(&rgb)
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: 1)
    }
    
}

extension UIImage {
    
    var original: UIImage { return self.withRenderingMode(.alwaysOriginal) }
    var template: UIImage { return self.withRenderingMode(.alwaysTemplate) }
    
}

extension UITableView {
    
    func registerNib(id: String) {
        self.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.id, for: indexPath) as! T
    }
    
}

extension UIView: NibLoadable {
    
    func addSubviewAsMatchParent(_ view: UIView) {
        self.addSubview(view)
        let leading = view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        let trailing = view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        let top = view.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        let bottom = view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
    
}

extension UIViewController: NibLoadable { }
