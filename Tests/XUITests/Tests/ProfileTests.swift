@testable import grokkoli
import XCTest

class ProfileTests: BaseTest {
	// dependency injection
	lazy var profilePage: ProfilePage = .init(app: app)
	
	func testProfileWithValidCredentials() {
		login()
		profilePage.clickProfileIcon()
		profilePage.enterName("Grok Grokkoli")
		profilePage.enterDOB("10/24/2024")
		profilePage.enterEmail("grokkoli@grokkoli.com")
		profilePage.enterPhoneNum(7777777777)
		profilePage.saveProfile()
		XCTAssertTrue(profilePage.isProfileCreated(), "Error Tripple Check and Debug")
	}
}
