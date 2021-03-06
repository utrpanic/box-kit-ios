//
//  FoundationExtensions.swift
//  BoxKit
//
//  Created by box-jeon on 2020/01/23.
//

import UIKit

extension IndexPath {
    
    public var next: IndexPath {
        return IndexPath(item: self.item + 1, section: self.section)
    }
    
    public var previous: IndexPath {
        return IndexPath(item: self.item - 1, section: self.section)
    }
}

extension NSAttributedString {
    
    public var totalRange: NSRange {
        return NSRange(location: 0, length: self.length)
    }
    
    public func attributes(at location: Int = 0) -> [NSAttributedString.Key: Any]? {
        guard location < self.length else { return nil }
        return self.attributes(at: location, effectiveRange: nil)
    }
    
    public func font(at location: Int = 0) -> UIFont? {
        guard location < self.length else { return nil }
        return self.attribute(.font, at: location, effectiveRange: nil) as? UIFont
    }
    
    public func lineSpacing(at location: Int = 0) -> CGFloat? {
        guard location < self.length else { return nil }
        return self.paragraphStyle(at: location)?.lineSpacing
    }
    
    public func minimumLineHeight(at location: Int = 0) -> CGFloat? {
        guard location < self.length else { return nil }
        return self.paragraphStyle(at: location)?.minimumLineHeight
    }
    
    public func maximumLineHeight(at location: Int = 0) -> CGFloat? {
        guard location < self.length else { return nil }
        return self.paragraphStyle(at: location)?.maximumLineHeight
    }
    
    public func alignment(at location: Int = 0) -> NSTextAlignment? {
        guard location < self.length else { return nil }
        return self.paragraphStyle(at: location)?.alignment
    }
    
    public func lineBreakMode(at location: Int = 0) -> NSLineBreakMode? {
        guard location < self.length else { return nil }
        return self.paragraphStyle(at: location)?.lineBreakMode
    }
    
    public func paragraphStyle(at location: Int) -> NSParagraphStyle? {
        guard location < self.length else { return nil }
        return self.attribute(.paragraphStyle, at: location, effectiveRange: nil) as? NSParagraphStyle
    }
    
    public func foregroundColor(at location: Int = 0) -> UIColor? {
        guard location < self.length else { return nil }
        return self.attribute(.foregroundColor, at: location, effectiveRange: nil) as? UIColor
    }
    
    public func backgroundColor(at location: Int = 0) -> UIColor? {
        guard location < self.length else { return nil }
        return self.attribute(.backgroundColor, at: location, effectiveRange: nil) as? UIColor
    }
    
    public func kern(at location: Int = 0) -> CGFloat? {
        guard location < self.length else { return nil }
        return self.attribute(.kern, at: location, effectiveRange: nil) as? CGFloat
    }
    
    public func link(at location: Int = 0) -> URL? {
        guard location < self.length else { return nil }
        return self.attribute(.link, at: location, effectiveRange: nil) as? URL
    }
    
    public func baselineOffset(at location: Int = 0) -> CGFloat? {
        guard location < self.length else { return nil }
        return self.attribute(.baselineOffset, at: location, effectiveRange: nil) as? CGFloat
    }
    
    public func underlineStyle(at location: Int = 0) -> NSUnderlineStyle? {
        guard location < self.length else { return nil }
        guard let rawValue = self.attribute(.underlineStyle, at: location, effectiveRange: nil) as? Int else { return nil }
        return NSUnderlineStyle(rawValue: rawValue)
    }
    
    public func underlineColor(at location: Int = 0) -> UIColor? {
        guard location < self.length else { return nil }
        return self.attribute(.underlineColor, at: location, effectiveRange: nil) as? UIColor
    }
}

extension NSMutableAttributedString {
    
    public func setAttributes(_ attributes: [NSAttributedString.Key: Any], range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        self.addAttributes(attributes, range: range)
        return self
    }
    
    public func setFont(_ value: UIFont, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        self.addAttribute(.font, value: value, range: range)
        return self
    }
    
    public func setLineSpacing(_ value: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        let mutable = self.mutableParagraphStyle(at: range.location)
        mutable.lineSpacing = value
        self.addAttribute(.paragraphStyle, value: mutable, range: range)
        return self
    }
    
    public func setMinimumLineHeight(_ value: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        let mutable = self.mutableParagraphStyle(at: range.location)
        mutable.minimumLineHeight = value
        self.addAttribute(.paragraphStyle, value: mutable, range: range)
        return self
    }
    
    public func setMaximumLineHeight(_ value: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        let mutable = self.mutableParagraphStyle(at: range.location)
        mutable.maximumLineHeight = value
        self.addAttribute(.paragraphStyle, value: mutable, range: range)
        return self
    }
    
    public func setAlignment(_ value: NSTextAlignment, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        let mutable = self.mutableParagraphStyle(at: range.location)
        mutable.alignment = value
        self.addAttribute(.paragraphStyle, value: mutable, range: range)
        return self
    }
    
    public func setLineBreakMode(_ value: NSLineBreakMode, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        let mutable = self.mutableParagraphStyle(at: range.location)
        mutable.lineBreakMode = value
        self.addAttribute(.paragraphStyle, value: mutable, range: range)
        return self
    }
    
    private func mutableParagraphStyle(at location: Int) -> NSMutableParagraphStyle {
        let mutable: NSMutableParagraphStyle
        if let paragraphStyle = self.paragraphStyle(at: location) {
            if paragraphStyle is NSMutableParagraphStyle {
                mutable = paragraphStyle as! NSMutableParagraphStyle
            } else {
                mutable = paragraphStyle.mutableCopy() as! NSMutableParagraphStyle
            }
        } else {
            mutable = NSMutableParagraphStyle()
            // NSParagraphStyle의 default alignment는 center.
            mutable.alignment = .left
        }
        return mutable
    }
    
    public func setForegroundColor(_ value: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        self.addAttribute(.foregroundColor, value: value, range: range)
        return self
    }
    
    public func setBackgroundColor(_ value: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        self.addAttribute(.backgroundColor, value: value, range: range)
        return self
    }
    
    public func setKern(_ value: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        self.addAttribute(.kern, value: value, range: range)
        return self
    }
    
    public func setLink(_ value: URL, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        self.addAttribute(.link, value: value, range: range)
        return self
    }
    
    public func setBaselineOffset(_ value: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        self.addAttribute(.baselineOffset, value: value, range: range)
        return self
    }
    
    public func setUnderlineStyle(_ value: NSUnderlineStyle, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        self.addAttribute(.underlineStyle, value: value.rawValue, range: range)
        return self
    }
    
    public func setUnderlineColor(_ value: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? self.totalRange
        self.addAttribute(.underlineColor, value: value, range: range)
        return self
    }
}

extension NSString {
    
    public var totalRange: NSRange {
        return NSRange(location: 0, length: self.length)
    }
}

extension URL {
    
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
    
    public var mimeType: String? {
        return self.mimeTypes[self.pathExtension.lowercased()]
    }
}
