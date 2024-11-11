//
//  UserProfileView.swift
//  grokkoli
//
//  Created by Jen on 11/2/24.
//

import SwiftUI

struct UserProfileView: View {
	@EnvironmentObject var appState: AppState //  AppState access  (AppState is injected in a parent view)
	@ObservedObject private var profileManager: ProfileManager
	@State private var showAlert = false

	init(profileManager: ProfileManager) {
		self.profileManager = profileManager
	}

	var body: some View {
		NavigationStack { // NavigationStack for iOS 17 and later compatibility
			Form {
				// Character Filtering
				TextField("Name", text: $profileManager.userDetails.name)
					.autocapitalization(.words)

				TextField("Date of Birth (MM/DD/YYYY)", text: $profileManager.userDetails.dateOfBirth)
					.keyboardType(.numbersAndPunctuation)

				// Standard Validation
				TextField("Email", text: $profileManager.userDetails.email)
					.keyboardType(.emailAddress)

				// Length Validation
				TextField("Phone Number", text: $profileManager.userDetails.phoneNumber)
					.keyboardType(.phonePad)
			}
			.navigationTitle("User Profile")
			.navigationBarTitleDisplayMode(.automatic)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button("Save") {
						if profileManager.validateProfile() {
							profileManager.isProfileSaved = true
						} else {
							showAlert = true
						}
					}.font(.headline).foregroundStyle(Color.darkGreen.gradient)
						.accessibilityIdentifier("SaveButton")
				}
				ToolbarItem(placement: .bottomBar) {
					Button("Log Out") {
						appState.logOut() // calls logOut from AppState
					}.font(.headline).foregroundStyle(Color.darkGreen)
				}
			}
			.alert("Validation Error", isPresented: $showAlert) {
				Button("OK", role: .cancel) {}
			} message: {
				Text(profileManager.alertMessage)
			}
			.navigationDestination(isPresented: $profileManager.isProfileSaved) {
				ProfileDisplayView(profile: profileManager.userDetails)
			}
		}
	}
}


struct UserProfileView_Previews: PreviewProvider {
	static var previews: some View {
			
		let mockProfileManager = ProfileManager()
		mockProfileManager.userDetails = UserProfile(
			name: "Abe Lincoln",
			dateOfBirth: "01/02/2003",
			email: "john.doe@example.com",
			phoneNumber: "9876543211"
		)
		
		return UserProfileView(profileManager: mockProfileManager)
			.environmentObject(AppState())
	}
}

