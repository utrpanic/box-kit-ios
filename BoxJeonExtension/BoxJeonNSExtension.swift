//
//  BoxJeonNSExtension.swift
//  BoxJeonExtension
//
//  Created by gurren-l on 2018. 5. 14..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

public extension NSAttributedString {
    
    var totalRange: NSRange {
        return NSRange(location: 0, length: self.length)
    }
}

public extension NSString {
    
    var totalRange: NSRange {
        return NSRange(location: 0, length: self.length)
    }
}
