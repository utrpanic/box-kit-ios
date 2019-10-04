
public protocol HttpStatusCodeProtocol {
    
    var value: Int { get }
    
    init(value: Int?)
}

// https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
// https://tools.ietf.org/html/rfc6585
extension HttpStatusCodeProtocol {
    
    // Informational 1xx
    public static var `continue`: Self { return Self(value: 100) }
    public static var switchingProtocol: Self { return Self(value: 101) }
    
    // Successful 2xx
    public static var ok: Self { return Self(value: 200) }
    public static var created: Self { return Self(value: 201) }
    public static var accepted: Self { return Self(value: 202) }
    public static var nonAuthoritativeInformation: Self { return Self(value: 203) }
    public static var noContent: Self { return Self(value: 204) }
    public static var resetContent: Self { return Self(value: 205) }
    public static var partialContent: Self { return Self(value: 206) }
    
    // Redirection 3xx
    public static var multipleChoices: Self { return Self(value: 300) }
    public static var movedPermanently: Self { return Self(value: 301) }
    public static var found: Self { return Self(value: 302) }
    public static var seeOther: Self { return Self(value: 303) }
    public static var notModified: Self { return Self(value: 304) }
    public static var useProxy: Self { return Self(value: 305) }
    public static var temporaryRedirect: Self { return Self(value: 307) }
    
    // Client Error 4xx
    public static var badRequest: Self { return Self(value: 400) }
    public static var unauthorized: Self { return Self(value: 401) }
    public static var paymentRequired: Self { return Self(value: 402) }
    public static var forbidden: Self { return Self(value: 403) }
    public static var notFound: Self { return Self(value: 404) }
    public static var methodNotAllowed: Self { return Self(value: 405) }
    public static var notAcceptable: Self { return Self(value: 406) }
    public static var proxyAuthenticationRequired: Self { return Self(value: 407) }
    public static var requestTimeout: Self { return Self(value: 408) }
    public static var conflict: Self { return Self(value: 409) }
    public static var gone: Self { return Self(value: 410) }
    public static var lengthRequired: Self { return Self(value: 411) }
    public static var preconditionFailed: Self { return Self(value: 412) }
    public static var requestEntityTooLarge: Self { return Self(value: 413) }
    public static var requestUriTooLong: Self { return Self(value: 414) }
    public static var unsupportedMediaType: Self { return Self(value: 415) }
    public static var requestedRangeNotSatisfiable: Self { return Self(value: 416) }
    public static var expectationFailed: Self { return Self(value: 417) }
    public static var preconditionRequired: Self { return Self(value: 428) }
    public static var tooManyRequests: Self { return Self(value: 429) }
    public static var requestHeaderFieldsTooLarge: Self { return Self(value: 431) }
    
    // Server Error 5xx
    public static var internalServerError: Self { return Self(value: 500) }
    public static var notImplemented: Self { return Self(value: 501) }
    public static var badGateway: Self { return Self(value: 502) }
    public static var ServiceUnavailable: Self { return Self(value: 503) }
    public static var gatewayTimeout: Self { return Self(value: 504) }
    public static var httpVersionNotSupported: Self { return Self(value: 505) }
    public static var networkAuthenticationRequired: Self { return Self(value: 511) }
    
    public var isSucceed: Bool {
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
