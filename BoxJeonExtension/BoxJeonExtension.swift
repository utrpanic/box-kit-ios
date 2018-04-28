//
//  BoxJeonExtension.swift
//  BoxJeonExtension
//
//  Created by boxjeon on 2017. 10. 21..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

public extension Array {
    
    var hasElement: Bool { return !self.isEmpty }
}

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
    
    var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
    var urlDecoded: String {
        return self.removingPercentEncoding ?? self
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var length: Int {
        return self.utf16.count
    }
    
    func prefix(length: Int) -> String {
        guard 0 <= length else { return "" }
        guard length < self.length else { return self }
        return String(Substring(self.utf16.prefix(length)))
    }
    
    func suffix(length: Int) -> String {
        guard 0 <= length else { return "" }
        guard length < self.length else { return self }
        return String(Substring(self.utf16.suffix(length)))
    }
    
    func suffix(from: Int) -> String {
        guard 0 <= from else { return self }
        guard from < self.length else { return "" }
        return String(Substring(self.utf16.suffix(self.length - from)))
    }
    
    func substring(from: Int, length: Int) -> String {
        return self.suffix(from: from).prefix(length: length)
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

public extension URL {
    
    static func safeVersion(from string: String?) -> URL? {
        guard let string = self.unescapeHtmlCharacters(from: string) else { return nil }
        return URL(string: string) ?? URL(string: string.urlEncoded)
    }
    
    private static func unescapeHtmlCharacters(from string: String?) -> String? {
        guard string?.contains(";") == true else { return string }
        guard let data = string?.data(using: .utf8) else { return string }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html.rawValue,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributedString.string
        } else {
            return string
        }
    }
}
