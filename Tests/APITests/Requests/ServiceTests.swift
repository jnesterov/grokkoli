import Foundation
@testable import grokkoli
import XCTest

class ServiceTests: BaseTestAPI {
	func testRequestCreation_withValidEndpoint_shouldReturnCorrectURLRequest() {
		let getRequest = RequestType.getUserRequest
		let urlRequest = apiGenericModel.createRequest(from: getRequest)
		validateRequest(
			urlRequest,
			expectedURL: "https://my-json-server.typicode.com/jnesterov/grokAPI/users",
			expectedMethod: .get,
			expectedHeaders: ["Content-Type": "application/json"]
		)
	}

	func testDecodingError() {
		let mockRequest = RequestType.getUserRequest

		mockSession.error = nil
		mockSession.data = loadMockData(from: "invalidUserData")

		let result: Result<TestGlucoseDataModel, APIError>? = sendRequest(
			mockRequest,
			responseType: TestGlucoseDataModel.self
		)

		guard let result = result else {
			XCTFail("Expected result to be non-nil")
			return
		}

		switch result {
		case .failure(let error):
			XCTAssertEqual(error, .decodingError, "Expected decoding error but got \(error)")
			if error == .decodingError {
				logSuccess("Test passed with expected decoding error")
			}

		case .success:
			XCTFail("Expected failure, but got success with \(result)")
		}
	}
}
