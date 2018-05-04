//
//  HttpStatusCode.swift
//  BoxJeonExtension
//
//  Created by boxjeon on 2018. 5. 3..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

// https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
public struct HttpStatusCode: Equatable, CustomStringConvertible {
    
    // Informational 1xx
    public static var `continue`: HttpStatusCode { return HttpStatusCode(value: 100) }
    public static var switchingProtocol: HttpStatusCode { return HttpStatusCode(value: 101) }
    
    // Successful 2xx
    public static var ok: HttpStatusCode { return HttpStatusCode(value: 200) }
    public static var created: HttpStatusCode { return HttpStatusCode(value: 201) }
    public static var accepted: HttpStatusCode { return HttpStatusCode(value: 202) }
    public static var nonAuthoritativeInformation: HttpStatusCode { return HttpStatusCode(value: 203) }
    public static var noContent: HttpStatusCode { return HttpStatusCode(value: 204) }
    public static var resetContent: HttpStatusCode { return HttpStatusCode(value: 205) }
    public static var partialContent: HttpStatusCode { return HttpStatusCode(value: 206) }
    
    // Redirection 3xx
    public static var multipleChoices: HttpStatusCode { return HttpStatusCode(value: 300) }
    public static var movedPermanently: HttpStatusCode { return HttpStatusCode(value: 301) }
    public static var found: HttpStatusCode { return HttpStatusCode(value: 302) }
    public static var seeOther: HttpStatusCode { return HttpStatusCode(value: 303) }
    public static var notModified: HttpStatusCode { return HttpStatusCode(value: 304) }
    public static var useProxy: HttpStatusCode { return HttpStatusCode(value: 305) }
    public static var temporaryRedirect: HttpStatusCode { return HttpStatusCode(value: 307) }
    
    // Client Error 4xx
    public static var badRequest: HttpStatusCode { return HttpStatusCode(value: 400) }
    public static var unauthorized: HttpStatusCode { return HttpStatusCode(value: 401) }
    public static var paymentRequired: HttpStatusCode { return HttpStatusCode(value: 402) }
    public static var forbidden: HttpStatusCode { return HttpStatusCode(value: 403) }
    public static var notFound: HttpStatusCode { return HttpStatusCode(value: 404) }
    public static var methodNotAllowed: HttpStatusCode { return HttpStatusCode(value: 405) }
    public static var notAcceptable: HttpStatusCode { return HttpStatusCode(value: 406) }
    public static var proxyAuthenticationRequired: HttpStatusCode { return HttpStatusCode(value: 407) }
    public static var requestTimeout: HttpStatusCode { return HttpStatusCode(value: 408) }
    public static var conflict: HttpStatusCode { return HttpStatusCode(value: 409) }
    public static var gone: HttpStatusCode { return HttpStatusCode(value: 410) }
    public static var lengthRequired: HttpStatusCode { return HttpStatusCode(value: 411) }
    public static var preconditionFailed: HttpStatusCode { return HttpStatusCode(value: 412) }
    public static var requestEntityTooLarge: HttpStatusCode { return HttpStatusCode(value: 413) }
    public static var requestUriTooLong: HttpStatusCode { return HttpStatusCode(value: 414) }
    public static var unsupportedMediaType: HttpStatusCode { return HttpStatusCode(value: 415) }
    public static var requestedRangeNotSatisfiable: HttpStatusCode { return HttpStatusCode(value: 416) }
    public static var expectationFailed: HttpStatusCode { return HttpStatusCode(value: 417) }
    
    // Server Error 5xx
    public static var internalServerError: HttpStatusCode { return HttpStatusCode(value: 500) }
    public static var notImplemented: HttpStatusCode { return HttpStatusCode(value: 501) }
    public static var badGateway: HttpStatusCode { return HttpStatusCode(value: 502) }
    public static var ServiceUnavailable: HttpStatusCode { return HttpStatusCode(value: 503) }
    public static var gatewayTimeout: HttpStatusCode { return HttpStatusCode(value: 504) }
    public static var httpVersionNotSupported: HttpStatusCode { return HttpStatusCode(value: 505) }
    
    private let value: Int
    private let message: String
    
    public var isSucceed: Bool {
        return 200 <= value && value < 300
    }
    
    public init(value: Int?, message: String? = nil) {
        self.value = value ?? 0
        self.message = message ?? ""
    }
    
    // MARK: - Equatable
    public static func == (lhs: HttpStatusCode, rhs: HttpStatusCode) -> Bool {
        return lhs.value == rhs.value
    }
    
    // MARK: - CustomStringConvertible
    public var description: String {
        if self.message.isEmpty {
            return "[\(self.value)]"
        } else {
            return "[\(self.value): \(self.message)]"
        }
    }
}
