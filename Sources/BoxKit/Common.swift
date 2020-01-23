//
//  Common.swift
//  BoxKit
//
//  Created by box.jeon on 2020/01/23.
//

import Foundation

public protocol HasTypeName {
    
    static var typeName: String { get }
}

extension HasTypeName {
    
    public static var typeName: String { return String(describing: self) }
}

// https://www.swiftbysundell.com/articles/combining-value-and-reference-types-in-swift/
public struct Weak<Object: AnyObject> {
    
    public weak var object: Object?
}
