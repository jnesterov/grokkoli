//
//  ContentView.swift
//  grokkoli
//
//  Created by Jen on 10/24/24.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject var appState: AppState

	var body: some View {
		if appState.isLoggedIn {
			MainTabView()
		} else {
			LoginView()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
			
		let appState = AppState()
		appState.isLoggedIn = true
		let loggedInPreview = ContentView().environmentObject(appState)
		appState.isLoggedIn = false
		let loggedOutPreview = ContentView().environmentObject(appState)
		
		return Group {
			loggedInPreview
				.previewDisplayName("Logged In State")
			loggedOutPreview
				.previewDisplayName("Logged Out State")
		}
	}
}
