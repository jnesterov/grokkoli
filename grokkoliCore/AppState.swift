import Combine
import SwiftUI

public class AppState: ObservableObject {
	@Published var isLoggedIn: Bool = false

	func logIn() {
		isLoggedIn = true
	}

	func logOut() {
		isLoggedIn = false
	}
}

