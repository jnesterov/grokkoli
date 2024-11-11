@testable import grokkoli
import XCTest

class LoginTests: BaseTest {
	func testLoginWithValidCredentials() {
		loginPage.enterUsername("TestUser")
		loginPage.enterPassword("12345")
		loginPage.tapLoginButton()

		XCTAssertTrue(loginPage.isFetchNewReadingDisplayed(), "Login failed for valid credentials")
	}

	func testLoginWithInvalidCredentials() {
		loginPage.enterUsername("invalidUser")
		loginPage.enterPassword("invalidPassword")
		loginPage.tapLoginButton()

		if let errorMessage = loginPage.getErrorMessage() {
			print("Error Message: \(errorMessage)")
		}
		// Assert that the error message is displayed
		XCTAssertTrue(loginPage.isErrorLoginMsgDisplayed(), "Error message not displayed for invalid credentials")
	}
	
	func testFetchButton() {
		login()
		let fetchButton = app.buttons["Fetch New Reading"]
		XCTAssertTrue(fetchButton.exists, "Fetch button should exist.")
		fetchButton.tap()
	}
}
