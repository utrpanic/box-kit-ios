import AnyCodable

extension Array {
    
    public var toJsonString: String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self)
            return String(bytes: data, encoding: .utf8) ?? "[]"
        } catch {
            return "[]"
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
}

extension Dictionary {
    
    public var toJsonString: String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self)
            return String(bytes: data, encoding: .utf8) ?? "{}"
        } catch {
            return "{}"
        }
    }
}

extension Encodable {
    
    public func encodeToJsonString(with jsonEncoder: JSONEncoder) -> String? {
        guard let data = try? jsonEncoder.encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
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
