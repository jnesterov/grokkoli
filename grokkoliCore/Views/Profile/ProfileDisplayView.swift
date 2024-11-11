//
//  ProfileDisplayView.swift
//  grokkoli
//
//  Created by Jen on 11/3/24.
//

import SwiftUI

struct ProfileDisplayView: View {
	var profile: UserProfile // Receives UserProfile data to display
	
	var body: some View {
		VStack(alignment: .leading, spacing: 15) {
			Text(profile.name)
				.font(.title3)
				.foregroundStyle(
					LinearGradient(
						gradient: Gradient(colors: [.teal, .indigo]),
						startPoint: .top,
						endPoint: .bottom
					)
				)
				.padding(.bottom, 5)
			
			VStack(alignment: .leading, spacing: 10) {
				HStack {
					Text("Name:")
						.fontWeight(.semibold)
					Spacer()
					Text(profile.name)
						.foregroundStyle(.secondary)
				}
				HStack {
					Text("Date of Birth:")
						.fontWeight(.semibold)
					Spacer()
					Text(profile.dateOfBirth)
						.foregroundColor(.secondary)
				}
				
				HStack {
					Text("Email:")
						.fontWeight(.semibold)
					Spacer()
					Text(profile.email)
						.foregroundColor(.secondary)
				}
				
				HStack {
					Text("Phone Number:")
						.fontWeight(.semibold)
					Spacer()
					Text(profile.phoneNumber)
						.foregroundColor(.secondary)
				}
			}
			.padding()
			.background(Color(UIColor.systemGray6))
			.cornerRadius(10)
			.padding(.top, 10)
			
			Spacer()
		}
		.padding(.horizontal)
		.padding(.top, 10)
		.navigationTitle("Profile")
	}
}
