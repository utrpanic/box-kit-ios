import XCTest
@testable import BoxKit

final class SwiftTests: XCTestCase {
    
    func test_Arrya_HasElement() {
        let empty: [Int] = []
        XCTAssertFalse(empty.hasElement)
        let some: [Int] = [2, 3]
        XCTAssertTrue(some.hasElement)
    }
}
