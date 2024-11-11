import XCTest

class DashboardPage {
	private let app: XCUIApplication
	init(app: XCUIApplication) {
		self.app = app
	}

	private var profileIcon: XCUIElement {
		return app.staticTexts["Profile"]
	}

	private var totalReadings: XCUIElement {
		return app.staticTexts
			.containing(
				NSPredicate(format: "name BEGINSWITH[c]%@", "Total Readings:")
			).element
	}

	private var lastReading: XCUIElement {
		return app.staticTexts["Last Reading"]
	}

	private var glucoseLevel: XCUIElement {
		return app.staticTexts["Glucose Level"]
	}

	private var mgDL: XCUIElement {
		return app.staticTexts
			.containing(
				NSPredicate(format: "value MATCHES %@", "mg/dL")
			).element
	}
}
