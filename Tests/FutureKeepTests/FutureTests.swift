import XCTest
import Combine
import FutureKeep

final class FutureTests: XCTestCase {
    func testGet() {
        func async42() -> Future<Int, Never> {
            Future { promise in
                DispatchQueue
                    .global()
                    .asyncAfter(deadline: .now() + 1) {
                        promise(.success(42))
                    }
            }
        }
        
        do {
            let future = async42()
            var result: Int?
            let expectation = XCTestExpectation()
            future.get { value in
                result = value
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 3)
            
            XCTAssertEqual(result, 42)
        }
        
        do {
            let future = async42()
            var result: Int?
            let expectation = XCTestExpectation()
            future.map { $0 + 1 }.get { value in
                result = value
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 3)
            
            XCTAssertEqual(result, 43)
        }
    }
}
