//
//  BoxJeonExtension.swift
//  BoxJeonExtension
//
//  Created by boxjeon on 2017. 10. 21..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

public extension Dictionary where Key == NSAttributedStringKey, Value == Any {
    
    var asTypingAttributes: Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        self.forEach({ (key, value) in
            dictionary[key.rawValue] = value
        })
        return dictionary
    }
}

public extension KeyedDecodingContainerProtocol {
    
    public func decodeDateIfPresent(key: Self.Key) throws -> Date? {
        if let dateInMilliSeconds = try self.decodeIfPresent(Int.self, forKey: key) {
            return Date(timeIntervalSince1970: TimeInterval(dateInMilliSeconds) / 1000)
        } else {
            return nil
        }
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
    
    public func suffix(from index: Int) -> String {
        guard 0 <= index else { return self }
        guard index < self.length else { return "" }
        return String(Substring(self.utf16.suffix(self.length - index)))
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
