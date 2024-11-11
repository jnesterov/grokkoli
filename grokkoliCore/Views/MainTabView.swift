//
//  MainTabView.swift
//  grokkoli
//
//  Created by Jen on 11/3/24.
//

import SwiftUI

struct MainTabView: View {
	@StateObject private var profileManager = ProfileManager() 

	var body: some View {
		TabView {
			// Dashboard Tab
			DashboardView()
				.tabItem {
					Label("Dashboard", systemImage: "drop.fill")
				}
			// History Tab
			HistoryView()
				.tabItem {
					Label("History", systemImage: "clock")
				}

			// User Profile Tab
			UserProfileView(profileManager: profileManager)
				.tabItem {
					Label("Profile", systemImage: "person.crop.circle")
				}
		}
		.accentColor(.accent)
	}
}
