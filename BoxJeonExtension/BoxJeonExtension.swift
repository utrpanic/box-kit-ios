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

public extension Array where Array.Element: Equatable {
    
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
    
    var convertedToStringKey: [String: Any] {
        var dictionary: [String: Any] = [:]
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
    
    var totalRange: NSRange {
        return NSRange(location: 0, length: self.length)
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
        if args.isEmpty {
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

public extension URL {
    
    // https://github.com/onevcat/MimeType/blob/master/Sources/MimeType.swift
    private var mimeTypes: [String: String] {
        return [
            "html": "text/html",
            "htm": "text/html",
            "shtml": "text/html",
            "css": "text/css",
            "xml": "text/xml",
            "gif": "image/gif",
            "jpeg": "image/jpeg",
            "jpg": "image/jpeg",
            "js": "application/javascript",
            "atom": "application/atom+xml",
            "rss": "application/rss+xml",
            "mml": "text/mathml",
            "txt": "text/plain",
            "jad": "text/vnd.sun.j2me.app-descriptor",
            "wml": "text/vnd.wap.wml",
            "htc": "text/x-component",
            "png": "image/png",
            "tif": "image/tiff",
            "tiff": "image/tiff",
            "wbmp": "image/vnd.wap.wbmp",
            "ico": "image/x-icon",
            "jng": "image/x-jng",
            "bmp": "image/x-ms-bmp",
            "svg": "image/svg+xml",
            "svgz": "image/svg+xml",
            "webp": "image/webp",
            "woff": "application/font-woff",
            "jar": "application/java-archive",
            "war": "application/java-archive",
            "ear": "application/java-archive",
            "json": "application/json",
            "hqx": "application/mac-binhex40",
            "doc": "application/msword",
            "pdf": "application/pdf",
            "ps": "application/postscript",
            "eps": "application/postscript",
            "ai": "application/postscript",
            "rtf": "application/rtf",
            "m3u8": "application/vnd.apple.mpegurl",
            "xls": "application/vnd.ms-excel",
            "eot": "application/vnd.ms-fontobject",
            "ppt": "application/vnd.ms-powerpoint",
            "wmlc": "application/vnd.wap.wmlc",
            "kml": "application/vnd.google-earth.kml+xml",
            "kmz": "application/vnd.google-earth.kmz",
            "7z": "application/x-7z-compressed",
            "cco": "application/x-cocoa",
            "jardiff": "application/x-java-archive-diff",
            "jnlp": "application/x-java-jnlp-file",
            "run": "application/x-makeself",
            "pl": "application/x-perl",
            "pm": "application/x-perl",
            "prc": "application/x-pilot",
            "pdb": "application/x-pilot",
            "rar": "application/x-rar-compressed",
            "rpm": "application/x-redhat-package-manager",
            "sea": "application/x-sea",
            "swf": "application/x-shockwave-flash",
            "sit": "application/x-stuffit",
            "tcl": "application/x-tcl",
            "tk": "application/x-tcl",
            "der": "application/x-x509-ca-cert",
            "pem": "application/x-x509-ca-cert",
            "crt": "application/x-x509-ca-cert",
            "xpi": "application/x-xpinstall",
            "xhtml": "application/xhtml+xml",
            "xspf": "application/xspf+xml",
            "zip": "application/zip",
            "bin": "application/octet-stream",
            "exe": "application/octet-stream",
            "dll": "application/octet-stream",
            "deb": "application/octet-stream",
            "dmg": "application/octet-stream",
            "iso": "application/octet-stream",
            "img": "application/octet-stream",
            "msi": "application/octet-stream",
            "msp": "application/octet-stream",
            "msm": "application/octet-stream",
            "docx": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "xlsx": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            "pptx": "application/vnd.openxmlformats-officedocument.presentationml.presentation",
            "mid": "audio/midi",
            "midi": "audio/midi",
            "kar": "audio/midi",
            "mp3": "audio/mpeg",
            "ogg": "audio/ogg",
            "m4a": "audio/x-m4a",
            "ra": "audio/x-realaudio",
            "3gpp": "video/3gpp",
            "3gp": "video/3gpp",
            "ts": "video/mp2t",
            "mp4": "video/mp4",
            "mpeg": "video/mpeg",
            "mpg": "video/mpeg",
            "mov": "video/quicktime",
            "webm": "video/webm",
            "flv": "video/x-flv",
            "m4v": "video/x-m4v",
            "mng": "video/x-mng",
            "asx": "video/x-ms-asf",
            "asf": "video/x-ms-asf",
            "wmv": "video/x-ms-wmv",
            "avi": "video/x-msvideo"
        ]
    }
    
    var mimeType: String? {
        return self.mimeTypes[self.pathExtension.lowercased()]
    }
}
