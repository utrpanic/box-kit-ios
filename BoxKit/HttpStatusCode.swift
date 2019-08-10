
public protocol HttpStatusCodeProtocol {
    
    var value: Int { get }
    
    init(value: Int?)
}

// https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
// https://tools.ietf.org/html/rfc6585
public extension HttpStatusCodeProtocol {
    
    // Informational 1xx
    static var `continue`: Self { return Self(value: 100) }
    static var switchingProtocol: Self { return Self(value: 101) }
    
    // Successful 2xx
    static var ok: Self { return Self(value: 200) }
    static var created: Self { return Self(value: 201) }
    static var accepted: Self { return Self(value: 202) }
    static var nonAuthoritativeInformation: Self { return Self(value: 203) }
    static var noContent: Self { return Self(value: 204) }
    static var resetContent: Self { return Self(value: 205) }
    static var partialContent: Self { return Self(value: 206) }
    
    // Redirection 3xx
    static var multipleChoices: Self { return Self(value: 300) }
    static var movedPermanently: Self { return Self(value: 301) }
    static var found: Self { return Self(value: 302) }
    static var seeOther: Self { return Self(value: 303) }
    static var notModified: Self { return Self(value: 304) }
    static var useProxy: Self { return Self(value: 305) }
    static var temporaryRedirect: Self { return Self(value: 307) }
    
    // Client Error 4xx
    static var badRequest: Self { return Self(value: 400) }
    static var unauthorized: Self { return Self(value: 401) }
    static var paymentRequired: Self { return Self(value: 402) }
    static var forbidden: Self { return Self(value: 403) }
    static var notFound: Self { return Self(value: 404) }
    static var methodNotAllowed: Self { return Self(value: 405) }
    static var notAcceptable: Self { return Self(value: 406) }
    static var proxyAuthenticationRequired: Self { return Self(value: 407) }
    static var requestTimeout: Self { return Self(value: 408) }
    static var conflict: Self { return Self(value: 409) }
    static var gone: Self { return Self(value: 410) }
    static var lengthRequired: Self { return Self(value: 411) }
    static var preconditionFailed: Self { return Self(value: 412) }
    static var requestEntityTooLarge: Self { return Self(value: 413) }
    static var requestUriTooLong: Self { return Self(value: 414) }
    static var unsupportedMediaType: Self { return Self(value: 415) }
    static var requestedRangeNotSatisfiable: Self { return Self(value: 416) }
    static var expectationFailed: Self { return Self(value: 417) }
    static var preconditionRequired: Self { return Self(value: 428) }
    static var tooManyRequests: Self { return Self(value: 429) }
    static var requestHeaderFieldsTooLarge: Self { return Self(value: 431) }
    
    // Server Error 5xx
    static var internalServerError: Self { return Self(value: 500) }
    static var notImplemented: Self { return Self(value: 501) }
    static var badGateway: Self { return Self(value: 502) }
    static var ServiceUnavailable: Self { return Self(value: 503) }
    static var gatewayTimeout: Self { return Self(value: 504) }
    static var httpVersionNotSupported: Self { return Self(value: 505) }
    static var networkAuthenticationRequired: Self { return Self(value: 511) }
    
    var isSucceed: Bool {
        return 200 <= self.value && self.value < 300
    }
}

open class HttpStatusCode: HttpStatusCodeProtocol, Equatable, CustomStringConvertible {
    
    public let value: Int
    
    required public init(value: Int?) {
        self.value = value ?? 0
    }
    
    public static func == (lhs: HttpStatusCode, rhs: HttpStatusCode) -> Bool {
        return lhs.value == rhs.value
    }
    
    open var description: String {
        return "\(self.value)"
    }
}
