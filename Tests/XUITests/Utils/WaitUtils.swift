import XCTest

class WaitUtils {
	
	static func waitForElementToExist(_ element: XCUIElement, timeout: TimeInterval = 10) {
		let existsPredicate = NSPredicate(format: "exists == true")
		let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: element)

		let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
		if result != .completed {
			XCTFail("Element did not exist within \(timeout) seconds.")
		}
	}

	
	static func waitForElementToBeHittable(_ element: XCUIElement, timeout: TimeInterval = 10) {
		let hittablePredicate = NSPredicate(format: "isHittable == true")
		let expectation = XCTNSPredicateExpectation(predicate: hittablePredicate, object: element)

		let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
		if result != .completed {
			XCTFail("Element was not hittable within \(timeout) seconds.")
		}
	}

	
	static func waitForElementToAppear(_ element: XCUIElement, timeout: TimeInterval = 5) {
		let exists = element.waitForExistence(timeout: timeout)
		XCTAssertTrue(exists, "Failed to find element within \(timeout) seconds")
	}
}
