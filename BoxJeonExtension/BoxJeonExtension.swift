//
//  BoxJeonExtension.swift
//  BoxJeonExtension
//
//  Created by boxjeon on 2017. 10. 21..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

extension KeyedDecodingContainerProtocol {
    
    func decodeDateIfPresent(key: Self.Key) throws -> Date? {
        if let dateInMilliSeconds = try self.decodeIfPresent(Int.self, forKey: key) {
            return Date(timeIntervalSince1970: TimeInterval(dateInMilliSeconds) / 1000)
        } else {
            return nil
        }
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
