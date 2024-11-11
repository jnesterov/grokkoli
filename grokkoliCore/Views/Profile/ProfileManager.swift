//
//  ProfileManager.swift
//  grokkoli
//
//  Created by Jen on 11/3/24.
//

import Combine
import Foundation
import SwiftUI


struct UserProfile {
	var name = ""
	var dateOfBirth = ""
	var age = ""
	var email = ""
	var phoneNumber = ""
}

class ProfileManager: ObservableObject {
	@Published var userDetails = UserProfile()
	@Published var alertMessage: String = ""
	@Published var isProfileSaved: Bool = false
	@Published var showAlert: Bool = false

	// Validation functions
	func validateProfile() -> Bool {
		userDetails.name = userDetails.name.filter { $0.isLetter || $0.isWhitespace }

		if userDetails.dateOfBirth.isEmpty {
			alertMessage = "Date of Birth is required in MM/DD/YYYY format"
			showAlert = true
			return false
		}
		if let age = Int(userDetails.age), age < 7 || age > 100 {
			alertMessage = "Age must be between 7 and 100"
			showAlert = true
			return false
		}
		if !isValidEmail(userDetails.email) {
			alertMessage = "Please enter a valid email address"
			showAlert = true
			return false
		}
		if userDetails.phoneNumber.count != 10 || !userDetails.phoneNumber.allSatisfy(\.isNumber) {
			alertMessage = "Phone number must be 10 digits"
			showAlert = true
			return false
		}
		alertMessage = ""
		return true
	}

	public func isValidEmail(_ email: String) -> Bool {
		let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
		return emailPredicate.evaluate(with: email)
	}

	func saveProfile() {
		if validateProfile() {
			isProfileSaved = true
		} else {
			showAlert = true
		}
	}
}
