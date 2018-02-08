//
//  BoxJeonExtension.swift
//  BoxJeonExtension
//
//  Created by boxjeon on 2017. 10. 21..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

public extension Array where Array.Element : Equatable {
    
    func contains(_ element: Array.Element) -> Bool {
        return self.contains(where: { $0 == element })
    }
    
    @discardableResult
    mutating func remove(element: Array.Element) -> Bool {
        if let index = self.index(of: element) {
            self.remove(at: index)
            return true
        } else {
            return false
        }
    }
}

public extension Bool {
    
    mutating func toggle() {
        self = !self
    }
}

public extension Dictionary {
    
    var prettyPrint: String {
        return (self as NSDictionary).description
    }
}

public extension Dictionary where Key == NSAttributedStringKey, Value == Any {
    
    var convertedToStringKey: Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        self.forEach({ (key, value) in
            dictionary[key.rawValue] = value
        })
        return dictionary
    }
}

public extension Int {
    
    var decimalFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

public extension String {
    
    public var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
    public var urlDecoded: String {
        return self.removingPercentEncoding ?? self
    }
    
    public var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public var length: Int {
        return self.utf16.count
    }
    
    public func prefix(length: Int) -> String {
        guard 0 <= length else { return "" }
        guard length < self.length else { return self }
        return String(Substring(self.utf16.prefix(length)))
    }
    
    public func suffix(length: Int) -> String {
        guard 0 <= length else { return "" }
        guard length < self.length else { return self }
        return String(Substring(self.utf16.suffix(length)))
    }
    
    public func suffix(from: Int) -> String {
        guard 0 <= from else { return self }
        guard from < self.length else { return "" }
        return String(Substring(self.utf16.suffix(self.length - from)))
    }
    
    public func substring(from: Int, length: Int) -> String {
        return self.suffix(from: from).prefix(length: length)
    }
    
    public func localized(_ args: CVarArg...) -> String {
        let format = NSLocalizedString(self, comment: "")
        if args.count == 0 {
            return format
        } else {
            return String(format: format, arguments: args)
        }
    }
}
