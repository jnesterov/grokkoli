import XCTest

class ProfilePage {
	private let app: XCUIApplication
	init(app: XCUIApplication) {
		self.app = app
	}

	private var profileIcon: XCUIElement {
		return app.buttons["Profile"]
	}

	private var nameBox: XCUIElement {
		return app.textFields["Name"]
	}

	private var dobBox: XCUIElement {
		return app.textFields["Date of Birth (MM/DD/YYYY)"]
	}

	private var emailBox: XCUIElement {
		return app.textFields["Email"]
	}

	private var phoneNumBox: XCUIElement {
		return app.textFields["Phone Number"]
	}

	private var saveProfileBtn: XCUIElement {
		return app.buttons["SaveButton"]
	}

	private var displayText: XCUIElement {
		return app.navigationBars["User Profile"]
	}

	private var personalInfoText: XCUIElement {
		return app.staticTexts["PERSONAL INFORMATION"]
	}

	private var validationMsg: XCUIElement {
		return app.staticTexts["Validation Error"]
	}

	private var alertMsg: XCUIElement {
		return app.alerts["Phone number must be 10 digits."]
	}

	private var okBtn: XCUIElement {
		return app.buttons["OK"]
	}

	private var profileHeader: XCUIElement {
		return app.staticTexts["Profile"]
	}

	func clickProfileIcon() {
		profileIcon.tap()
	}

	func isProfileDisplayed()->Bool {
		return displayText.exists
	}

	func isPeronalInfoDisplayed()->Bool {
		return personalInfoText.exists
	}

	func isProfileCreated()->Bool {
		WaitUtils.waitForElementToAppear(profileHeader)
		return profileHeader.exists
	}

	func enterName(_ name: String) {
		nameBox.tap()
		nameBox.typeText(name)
	}

	func enterDOB(_ DOB: String) {
		dobBox.tap()
		dobBox.typeText(DOB)
	}

	func enterEmail(_ email: String) {
		emailBox.tap()
		emailBox.typeText(email)
	}

	func enterPhoneNum(_ phoneNumber: Int64) {
		phoneNumBox.tap()
		phoneNumBox.typeText(String(phoneNumber))
	}

	func scrollToElement(_ element: XCUIElement) {
		while !element.isHittable {
			app.swipeUp()
		}
	}

	func saveProfile() {
		XCTAssertTrue(saveProfileBtn.exists, "The Save button should exist")
		saveProfileBtn.tap()
	}

	func tapOK() {
		okBtn.tap()
	}
}
