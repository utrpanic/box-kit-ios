//
//  HttpStatusCode.swift
//  BoxJeonExtension
//
//  Created by boxjeon on 2018. 5. 3..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

// https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
public class HttpStatusCode: Equatable, CustomStringConvertible {
    
    // Informational 1xx
    static let `continue` = HttpStatusCode(value: 100)
    static let switchingProtocol = HttpStatusCode(value: 101)
    
    // Successful 2xx
    static let ok: HttpStatusCode = HttpStatusCode(value: 200)
    static let created: HttpStatusCode = HttpStatusCode(value: 201)
    static let accepted: HttpStatusCode = HttpStatusCode(value: 202)
    static let nonAuthoritativeInformation: HttpStatusCode = HttpStatusCode(value: 203)
    static let noContent: HttpStatusCode = HttpStatusCode(value: 204)
    static let resetContent: HttpStatusCode = HttpStatusCode(value: 205)
    static let partialContent: HttpStatusCode = HttpStatusCode(value: 206)
    
    // Redirection 3xx
    static let multipleChoices: HttpStatusCode = HttpStatusCode(value: 300)
    static let movedPermanently: HttpStatusCode = HttpStatusCode(value: 301)
    static let found: HttpStatusCode = HttpStatusCode(value: 302)
    static let seeOther: HttpStatusCode = HttpStatusCode(value: 303)
    static let notModified: HttpStatusCode = HttpStatusCode(value: 304)
    static let useProxy: HttpStatusCode = HttpStatusCode(value: 305)
    static let temporaryRedirect: HttpStatusCode = HttpStatusCode(value: 307)
    
    // Client Error 4xx
    static let badRequest: HttpStatusCode = HttpStatusCode(value: 400)
    static let unauthorized: HttpStatusCode = HttpStatusCode(value: 401)
    static let paymentRequired: HttpStatusCode = HttpStatusCode(value: 402)
    static let forbidden: HttpStatusCode = HttpStatusCode(value: 403)
    static let notFound: HttpStatusCode = HttpStatusCode(value: 404)
    static let methodNotAllowed: HttpStatusCode = HttpStatusCode(value: 405)
    static let notAcceptable: HttpStatusCode = HttpStatusCode(value: 406)
    static let proxyAuthenticationRequired: HttpStatusCode = HttpStatusCode(value: 407)
    static let requestTimeout: HttpStatusCode = HttpStatusCode(value: 408)
    static let conflict: HttpStatusCode = HttpStatusCode(value: 409)
    static let gone: HttpStatusCode = HttpStatusCode(value: 410)
    static let lengthRequired: HttpStatusCode = HttpStatusCode(value: 411)
    static let preconditionFailed: HttpStatusCode = HttpStatusCode(value: 412)
    static let requestEntityTooLarge: HttpStatusCode = HttpStatusCode(value: 413)
    static let requestUriTooLong: HttpStatusCode = HttpStatusCode(value: 414)
    static let unsupportedMediaType: HttpStatusCode = HttpStatusCode(value: 415)
    static let requestedRangeNotSatisfiable: HttpStatusCode = HttpStatusCode(value: 416)
    static let expectationFailed: HttpStatusCode = HttpStatusCode(value: 417)
    
    // Server Error 5xx
    static let internalServerError: HttpStatusCode = HttpStatusCode(value: 500)
    static let notImplemented: HttpStatusCode = HttpStatusCode(value: 501)
    static let badGateway: HttpStatusCode = HttpStatusCode(value: 502)
    static let ServiceUnavailable: HttpStatusCode = HttpStatusCode(value: 503)
    static let gatewayTimeout: HttpStatusCode = HttpStatusCode(value: 504)
    static let httpVersionNotSupported: HttpStatusCode = HttpStatusCode(value: 505)
    
    private var value: Int
    
    var isSucceed: Bool {
        return 200 <= value && value < 300
    }
    
    init(value: Int?) {
        self.value = value ?? 0
    }
    
    // MARK: - Equatable
    public static func == (lhs: HttpStatusCode, rhs: HttpStatusCode) -> Bool {
        return lhs.value == rhs.value
    }
    
    // MARK: - CustomStringConvertible
    public var description: String {
        return "\(self.value)"
    }
}
