@testable import grokkoli
import XCTest

class BaseTest: XCTestCase {
	let app = XCUIApplication()
	lazy var loginPage: LoginPage = .init(app: app)
	
	override func setUpWithError() throws {
		super.setUp()
		continueAfterFailure = false
		app.launch()
		print("Setting up test environment for \(self)")
	}
	
	override func tearDownWithError() throws {
		print("Tearing down test environment for \(self)")
		super.tearDown()
	}
	
	func waitForElementToAppear(_ element: XCUIElement, timeout: TimeInterval = 5) {
		let exists = element.waitForExistence(timeout: timeout)
		XCTAssertTrue(exists, "Failed to find element within \(timeout) seconds")
	}
    
	func assertElementExists(_ element: XCUIElement) {
		XCTAssertTrue(element.exists, "Expected element doesn't exist")
	}
	
	func inputText(_ text: String, into element: XCUIElement) {
		element.tap()
		element.typeText(text)
	}
	
	func tapElement(_ element: XCUIElement) {
		XCTAssertTrue(element.exists, "Element to tap doesn't exist")
	}
	
	func login(_ userName: String = "TestUser", _ password: String = "12345") {
		loginPage.login(username: userName, password: password)
		print("User logged in successfully")
	}
}


