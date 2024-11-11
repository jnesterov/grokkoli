//
//  HistoryView.swift
//  grokkoli
//
//  Created by Jen on 10/25/24.
//

import SwiftData
import SwiftUI

struct HistoryView: View {
	@Environment(\.modelContext) private var context: ModelContext // SwiftData Context
	@Query(sort: \GlucoseReading.timestamp, order: .reverse) private var readings: [GlucoseReading]
	@State private var selectedFilter: FilterOption = .all

	var body: some View {
		VStack {
			// Filter Picker for selecting time range
			Picker("Filter", selection: $selectedFilter) {
				ForEach(FilterOption.allCases, id: \.self) { option in
					Text(option.rawValue).tag(option)
				}
			}
			.pickerStyle(SegmentedPickerStyle())
			.padding()

			// List of filtered readings with Delete Action
			List {
				ForEach(filteredReadings) { reading in
					HStack {
						Text("\(reading.level) mg/dL")
						Spacer()
						Text(reading.timestamp, style: .date)
							.foregroundColor(.gray)
					}
				}
				.onDelete { indexSet in
					for index in indexSet {
						let reading = filteredReadings[index]
						context.delete(reading) // Delete from SwiftData context
					}
				}
			}
		}
		.navigationTitle("Reading History")
	}

	// Filtered readings based on the selected filter option
	private var filteredReadings: [GlucoseReading] {
		switch selectedFilter {
			case .all:
				return readings
			case .last7Days:
				return readings.filter { isInLast(days: 7, date: $0.timestamp) }
			case .last30Days:
				return readings.filter { isInLast(days: 30, date: $0.timestamp) }
		}
	}

	// Helper function to check if a date is within the last X days
	private func isInLast(days: Int, date: Date) -> Bool {
		let calendar = Calendar.current
		guard let daysAgo = calendar.date(byAdding: .day, value: -days, to: Date()) else { return false }
		return date >= daysAgo
	}
}

// Enum for the filter options
enum FilterOption: String, CaseIterable {
	case all = "All"
	case last7Days = "Last 7 Days"
	case last30Days = "Last 30 Days"
}
