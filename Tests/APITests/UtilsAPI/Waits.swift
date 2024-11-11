import XCTest

class Utils {
    
    
    @discardableResult
    static func waitForExpectation(_ expectation: XCTestExpectation, timeout: TimeInterval = 5) -> XCTWaiter.Result {
        return XCTWaiter.wait(for: [expectation], timeout: timeout)
    }
    
    
    static func waitForResponse<T>(_ apiCall: (@escaping (T) -> Void) -> Void, timeout: TimeInterval = 5) -> T? {
        let expectation = XCTestExpectation(description: "Waiting for API response")
        var response: T?
        
        apiCall { result in
            response = result
            expectation.fulfill()
        }
        
        _ = waitForExpectation(expectation, timeout: timeout)
        
        return response
    }
}
