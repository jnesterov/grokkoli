import Foundation

protocol Logger {
	func info(_ message: String)
	func success(_ message: String)
	func warning(_ message: String)
	func error(_ message: String)
	func debug(_ message: String)
	func logSectionStart(_ section: String)
	func logSectionEnd(_ section: String)
}

class ConsoleLogger: Logger {
	func info(_ message: String) {
		print("ℹ️ [INFO]: \(message)")
	}

	func success(_ message: String) {
		print("✅ [SUCCESS]: \(message)")
	}

	func warning(_ message: String) {
		print("⚠️ [WARNING]: \(message)")
	}

	func error(_ message: String) {
		print("❌ [ERROR]: \(message)")
	}

	func debug(_ message: String) {
		print("🛠 [DEBUG]: \(message)")
	}

	func logSectionStart(_ message: String) {
		print("🚀 [SECTION START]: \(message)")
	}

	func logSectionEnd(_ message: String) {
		print("✅ [SECTION END]: \(message)")
	}
}

class LoggerManager {
	static let shared: LoggerManager = .init()

	private let logger: Logger

	private init() {
		self.logger = ConsoleLogger()
	}

	func logInfo(_ message: String) {
		logger.info(message)
	}

	func logWarning(_ message: String) {
		logger.warning(message)
	}

	func logError(_ message: String) {
		logger.error(message)
	}

	func logDebug(_ message: String) {
		logger.debug(message)
	}

	func logSuccess(_ message: String) {
		logger.success(message)
	}

	func logSectionStart(_ message: String) {
		logger.logSectionStart(message)
	}

	func logSectionEnd(_ message: String) {
		logger.logSectionEnd(message)
	}
}

func logSession(_ message: String) {
	LoggerManager.shared.logInfo("🔄 SESSION STARTED... " + message)
}

func logInfo(_ message: String) {
	LoggerManager.shared.logInfo("ℹ️ " + message)
}

func logWarning(_ message: String) {
	LoggerManager.shared.logWarning("⚠️ " + message)
}

func logError(_ message: String) {
	LoggerManager.shared.logError("❌ " + message)
}

func logDebug(_ message: String) {
	LoggerManager.shared.logDebug("🔍 DEBUGGING HERE " + message)
}

func logSuccess(_ message: String) {
	LoggerManager.shared.logSuccess("🎉 Success: " + message)
}

func logSectionStart(_ message: String) {
	LoggerManager.shared.logSectionStart("🟢 Starting data retrieval " + message)
}

func logSectionEnd(_ message: String) {
	LoggerManager.shared.logSectionEnd("🔴 Completed data retrieval " + message)
}
