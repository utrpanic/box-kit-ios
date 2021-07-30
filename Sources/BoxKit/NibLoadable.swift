//
//  NibLoadable.swift
//  BoxKit
//
//  Created by box-jeon on 2020/01/23.
//

import UIKit

extension UIView: HasTypeName {}

extension UIViewController: HasTypeName {}

public protocol NibLoadable {
    
}

extension NibLoadable where Self: UIView {
    
    public static func createFromNib() -> Self? {
        let bundle = Bundle(for: self)
        let views = bundle.loadNibNamed(self.typeName, owner: nil, options: nil)
        for index in 0 ..< (views?.count ?? 0) {
            if let view = views?[index] as? Self {
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }
        }
        return nil
    }
    
    public static func createFromNib(frame: CGRect) -> Self? {
        let view = self.createFromNib()
        view?.translatesAutoresizingMaskIntoConstraints = true
        view?.frame = frame
        return view
    }
}

extension NibLoadable where Self: UIViewController {
    
    public static func create(storyboardName: String) -> Self {
        let storyboard = StoryboardCenter.shared.retrieve(name: storyboardName)
        return storyboard.instantiateViewController(identifier: self.typeName, creator: nil)
    }
}

class StoryboardCenter {
    
    static let shared: StoryboardCenter = StoryboardCenter()
    
    private var cache: [String: Weak<UIStoryboard>] = [:]
    
    func retrieve(name: String) -> UIStoryboard {
        if let storyboardContainer = self.cache[name] {
            if let storyboard = storyboardContainer.object {
                return storyboard
            } else {
                self.cache.removeValue(forKey: name)
            }
        }
        let storyboard = UIStoryboard(name: name, bundle: nil)
        self.cache[name] = Weak(object: storyboard)
        return storyboard
    }
}
