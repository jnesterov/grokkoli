//
//  LoginView.swift
//  grokkoli
//
//  Created by Jen on 10/30/24.
//

import SwiftUI

struct LoginView: View {
	@EnvironmentObject var appState: AppState // login state and session management
	@State private var username: String = ""
	@State private var password: String = ""
	@State private var loginFailed: Bool = false

	var body: some View {
		NavigationStack {
			VStack(spacing: 20) {
				Text("grokkoli")
					.font(.largeTitle)
					.bold()
				
				// Username Field
				TextField("Username", text: $username)
					.padding()
					.background(Color(.systemGray6))
					.cornerRadius(8)
					.textInputAutocapitalization(.never)
				
				// Password Field
				SecureField("Password", text: $password)
					.padding()
					.background(Color(.systemGray6))
					.cornerRadius(8)
					.onSubmit {
						login() // Triggers login when Enter is pressed
					}
				
				// Login Button
				Button(action: login) {
					Text("Login")
						.bold()
						.foregroundColor(.white)
						.frame(maxWidth: .infinity)
						.padding()
						.background(Color.darkGreen)
						.cornerRadius(8)
				}
				
				if loginFailed {
					Text("Invalid username or password.")
						.foregroundColor(.red)
						.font(.caption)
						.padding(.top, 10)
				}
			}
			.padding()
		}
	}
	
	// Login Action
	private func login() {
		print("LOGGING IN...")
		if username == "TestUser" && password == "12345" {
			appState.isLoggedIn = true
		} else {
			loginFailed = true
		}
	}
}
