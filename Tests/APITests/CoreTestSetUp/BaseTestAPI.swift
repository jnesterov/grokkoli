@testable import grokkoli
import XCTest

class BaseTestAPI: XCTestCase {
	var apiGenericModel: APIService!
	var mockSession: MockSession!

	override func setUp() {
		super.setUp()
		mockSession = MockSession()
		apiGenericModel = APIService()
	}

	override func tearDown() {
		apiGenericModel = nil
		mockSession = nil
		super.tearDown()
	}

	func createAndValidateURLRequest(apiRequest: APIRequest) -> URLRequest? {
		guard let baseURL = apiGenericModel.baseURL else {
			XCTFail("Base URL is not defined")
			return nil
		}

		_ = baseURL.appendingPathComponent(apiRequest.endpoint)

		guard let request = apiGenericModel.createRequest(from: apiRequest) else {
			XCTFail("Failed to create URLRequest")
			return nil
		}

		validateRequest(request,
		                expectedURL: apiRequest.endpoint,
		                expectedMethod: apiRequest.httpMethod)
		return request
	}

	func sendRequest<T: Decodable>(_ request: APIRequest, responseType: T.Type) -> Result<T, APIError>? {
		let expectation = self.expectation(description: "Completion handler invoked")
		var result: Result<T, APIError>?

		apiGenericModel.sendRequest(request, responseType: responseType) { response in
			result = response
			expectation.fulfill()
		}

		waitForExpectations(timeout: 5, handler: nil)
		return result
	}

	func validateRequest(
		_ request: URLRequest?,
		expectedURL: String? = nil,
		expectedMethod: HttpMethod? = nil,
		expectedHeaders: [String: String]? = nil
	) {
		XCTAssertNotNil(request)

		if let expectedURL = expectedURL {
			XCTAssertEqual(request?.url?.absoluteString, expectedURL, "URL does not match")
		}

		if let expectedMethod = expectedMethod {
			XCTAssertEqual(request?.httpMethod, expectedMethod.rawValue, "HTTP method does not match")
		}

		if let headers = expectedHeaders {
			for (header, value) in headers {
				XCTAssertEqual(request?.value(forHTTPHeaderField: header), value, "Header \(header) does not match")
			}
		}
	}

	func loadMockData(from fileName: String) -> Data? {
		let bundle = Bundle(for: type(of: self))
		guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
			XCTFail("Missing file: \(fileName).json")
			let bundle = Bundle(for: type(of: self))
			print("Bundle path:", bundle.bundlePath)

			return nil
		}
		return try? Data(contentsOf: url)
	}
}
