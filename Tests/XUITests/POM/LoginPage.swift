import XCTest

class LoginPage {
	private let app: XCUIApplication
	
	init(app: XCUIApplication) { 
		self.app = app
	}
	
	// Locators
	private var usernameField: XCUIElement {
		return app.textFields["Username"]
	}
	
	private var passwordField: XCUIElement {
		return app.secureTextFields["Password"]
	}
	
	private var loginButton: XCUIElement {
		return app.buttons["Login"]
	}
	
	private var fetchBtn: XCUIElement {
		return app.buttons["Fetch New Reading"]
	}
	
	private var errorLoginMsg: XCUIElement {
		return app.staticTexts["Invalid username or password."]
	}

	// Actions
	func enterUsername(_ username: String) {
		usernameField.tap()
		usernameField.typeText(username)
	}
	
	func enterPassword(_ password: String) {
		passwordField.tap()
		passwordField.typeText(password)
	}
	
	func tapLoginButton() {
		loginButton.tap()
	}
	
	func login(username: String, password: String) {
		enterUsername(username)
		enterPassword(password)
		tapLoginButton()
	}
	
	func isErrorLoginMsgDisplayed() -> Bool {
		return errorLoginMsg.exists
	}
	
	func isFetchNewReadingDisplayed() -> Bool {
		return fetchBtn.exists
	}
	
	func getErrorMessage() -> String? {
		return errorLoginMsg.exists ? errorLoginMsg.label : nil
	}
}
