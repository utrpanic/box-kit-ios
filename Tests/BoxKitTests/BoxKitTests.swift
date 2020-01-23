import XCTest
@testable import BoxKit

final class BoxKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BoxKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
