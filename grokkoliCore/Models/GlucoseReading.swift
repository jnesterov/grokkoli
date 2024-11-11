import Foundation
import SwiftData

@Model
final class GlucoseReading: Identifiable {
	@Attribute(.unique) var id: UUID // Unique ID for each reading
	@Attribute var level: Int // Glucose level
	@Attribute var timestamp: Date // Timestamp for when reading was taken

	init(level: Int, timestamp: Date = Date()) {
		self.id = UUID()
		self.level = level
		self.timestamp = timestamp
	}
}
