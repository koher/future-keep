import XCTest
import Combine
import FutureKeep

final class FutureKeepTests: XCTestCase {
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func testExample() {
        func async42() -> Future<Int, Never> {
            Future { promise in
                DispatchQueue
                    .global()
                    .asyncAfter(deadline: .now() + 3) {
                        promise(.success(42))
                    }
            }
        }
        
        let future = async42()
        let expectation = XCTestExpectation()
        if always() {
            future.get { value in
                XCTAssertEqual(value, 42)
                expectation.fulfill()
            }
        } else {
            // Fails
            _ = future.sink { value in
                XCTAssertEqual(value, 42)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}

private func always() -> Bool { true }
