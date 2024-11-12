import Foundation
@testable import grokkoli

class MockSession: URLSessionProtocol {
	var data: Data?
	var response: URLResponse?
	var error: Error?
	@available(iOS, deprecated: 13.0, message: "Mock class for testing purposes")
	func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		return MockDataTask {
			completionHandler(self.data, self.response, self.error)
		}
	}
}

class MockDataTask: URLSessionDataTask, @unchecked Sendable {
	private let closure: () -> Void
	@available(iOS, deprecated: 13.0, message: "Mock class for testing purposes")
	init(closure: @escaping () -> Void) {
		self.closure = closure
	}

	override func resume() {
		closure()
	}
}
