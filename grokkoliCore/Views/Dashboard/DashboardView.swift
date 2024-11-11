//
//  DashboardView.swift
//  grokkoli
//
//  Created by Jen on 10/24/24.

import SwiftData
import SwiftUI

struct DashboardView: View {
	@Environment(\.modelContext) private var context: ModelContext
	@Query(sort: \GlucoseReading.timestamp, order: .reverse) private var readings: [GlucoseReading]

	// State variable to trigger animation
	@State private var animateChange = false

	var body: some View {
		VStack(spacing: 20) {
			HStack {
				Text("Glucose Level Readings:")
					.font(.headline)
					.fontWeight(.bold)
					.foregroundStyle(Color.darkGreen.gradient)
				Text("\(readings.count)")
					.font(.footnote)
					.fontWeight(.bold)
					.foregroundColor(.gray)
			}
			.frame(maxWidth: .infinity, alignment: .center)

			if let latestReading = readings.first {
				let glucoseMessage = GlucoseEnum.fromGlucoseLevel(
					latestReading.level
				)
				ZStack {
					// Black Rounded Rectangle (Container)
					RoundedRectangle(cornerRadius: 12)
						.fill(Color.black.gradient.secondary)
						.frame(width: 250, height: 120)

					VStack(spacing: 5) {
						HStack {
							Text("Risk Level:")
								.font(.caption)
								.fontWeight(.bold)
								.foregroundColor(.yellow)

							Text(glucoseMessage.riskLevel)
								.font(.caption)
								.fontWeight(.semibold)
								.foregroundColor(glucoseMessage.color)
						}

						// Glucose Reading Value
						Text("\(latestReading.level) mg/dL")
							.font(.system(size: 36, weight: .medium))
							.foregroundColor(.white)
							.scaleEffect(animateChange ? 1.1 : 1.0)
							.animation(.easeInOut(duration: 0.5), value: animateChange)

						Text(glucoseMessage.message)
							.font(.footnote)
							.fontWeight(.medium)
							.foregroundStyle(Color.black)
					}
				}
				.onAppear {
					animateChange.toggle() // Starts animation on appear
				}
			}

			// Fetch New Reading Button
			Button("Fetch New Reading") {
				withAnimation {
					let newReading = GlucoseReading(level: Int.random(in: 50 ... 250))
					print("NEW READING GENERATED: \(newReading.level) mg/dL")
					context.insert(newReading) // Inserts new reading
					print("NEW READING: \(newReading.level) added.") // Debugs print
					animateChange.toggle() // Triggers animation
				}
			}
			.padding()
			.background(Capsule().fill(Color.darkGreen.gradient))
			.foregroundColor(.white)
			.fontWeight(.bold)
			.font(.headline)
			.fontWeight(.bold)
		}
		.padding(.horizontal, 40)
	}
}



