//
//  Swift+Extension.swift
//  BoxKit
//
//  Created by box-jeon on 2020/01/23.
//

import UIKit
import AnyCodable

extension Array {
    
    public var hasElement: Bool { return !self.isEmpty }
    
    public var toJsonString: String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self)
            return String(bytes: data, encoding: .utf8) ?? "[]"
        } catch {
            return "[]"
        }
    }
}

extension Array where Array.Element: Equatable {
    
    public func contains(_ element: Array.Element) -> Bool {
        return self.contains(where: { $0 == element })
    }
    
    @discardableResult
    public mutating func remove(element: Array.Element) -> Bool {
        if let index = self.firstIndex(of: element) {
            self.remove(at: index)
            return true
        } else {
            return false
        }
    }
}

extension Array where Array.Element: Encodable {
    
    public func encodeToJsonStrings(with jsonEncoder: JSONEncoder) -> [String] {
        return self.compactMap({
            guard let data = try? jsonEncoder.encode($0) else { return nil }
            return String(data: data, encoding: .utf8)
        })
    }
}

extension DecodingError: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        switch self {
        case .dataCorrupted(let context),
             .keyNotFound(_, let context),
             .typeMismatch(_, let context),
             .valueNotFound(_, let context):
            return context.debugDescription
        @unknown default:
            return self.localizedDescription
        }
    }
    
    public var codingPath: String {
        switch self {
        case let .dataCorrupted(context),
             let .keyNotFound(_, context),
             let .typeMismatch(_, context),
             let .valueNotFound(_, context):
            return context.codingPath.map { $0.stringValue }.joined(separator: ".")
        @unknown default:
            return "None"
        }
    }
}

extension Dictionary {
    
    public var prettyPrint: String {
        return (self as NSDictionary).description
    }
    
    public var toJsonString: String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self)
            return String(bytes: data, encoding: .utf8) ?? "{}"
        } catch {
            return "{}"
        }
    }
}

extension Double {
    public var cg: CGFloat { CGFloat(self) }
}

extension Encodable {
    
    public func encodeToJsonString(with jsonEncoder: JSONEncoder) -> String? {
        guard let data = try? jsonEncoder.encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Float {
    public var cg: CGFloat { CGFloat(self) }
}

extension Int {
    
    public var cg: CGFloat { CGFloat(self) }
    
    public var decimalFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

extension KeyedDecodingContainer {
    
    public func decode(_ type: UIColor.Type, forKey key: K) throws -> UIColor? {
        let hex = try decode(String.self, forKey: key)
        return UIColor(hex: hex)
    }
    
    public func tolerantDecode<T: Decodable>(arrayOf type: T.Type, forKey key: K) throws -> [T] {
        guard var unkeyedContainer = try? self.nestedUnkeyedContainer(forKey: key) else {
            return []
        }
        var array: [T] = []
        while !unkeyedContainer.isAtEnd {
            do {
                array.append(try unkeyedContainer.decode(type))
            } catch {
                if let error = error as? DecodingError {
                    Log.i("[Ignore Decoding Error]: \(error.debugDescription)")
                } else {
                    Log.i("[Ignore Unknown Error]: \(error.localizedDescription)")
                }
                _ = try? unkeyedContainer.decode(AnyDecodable.self)
            }
        }
        return array
    }
}

extension Set {
    var hasElement: Bool { !self.isEmpty }
}

extension String {
    
    public var ns: NSString {
        return self as NSString
    }
    
    public var attributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
    
    public var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
    public var urlDecoded: String {
        return self.removingPercentEncoding ?? self
    }
    
    public var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public var whenVisible: String? {
        let trimmed = self.trimmed
        return trimmed.isEmpty ? nil : trimmed
    }
    
    public var hasElement: Bool {
        return !self.isEmpty
    }
    
    public func prefix(length: Int) -> String {
        return String(self.prefix(length))
    }
    
    public func suffix(length: Int) -> String {
        return String(self.suffix(length))
    }
    
    public func suffix(from start: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: start)
        return String(self.suffix(from: index))
    }
    
    public func localized(_ args: CVarArg...) -> String {
        let format = NSLocalizedString(self, comment: "")
        if args.isEmpty {
            return format
        } else {
            return String(format: format, arguments: args)
        }
    }
}

extension URL {
    
    public static func safeVersion(from string: String?) -> URL? {
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

