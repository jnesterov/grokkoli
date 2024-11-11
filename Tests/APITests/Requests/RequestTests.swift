import Foundation
@testable import grokkoli
import XCTest

class RequestTests: BaseTestAPI {
	func testSuccessfulRequest() {
		let getRequest = RequestType.getGlucoseDataRequest

		let response = sendRequest(getRequest, responseType: [TestGlucoseDataModel].self)

		switch response {
		case .success(let data):
			XCTAssertNotNil(data)
			XCTAssertGreaterThan(data.count, 0)

			if let firstUserData = data.first {
				logInfo("ID: \(firstUserData.id)")
				print("Glucose Level:\(firstUserData.glucoseLevel)")
				print("Risk Status:\(firstUserData.riskStatus)")
				print("Timestamp:\(firstUserData.timestamp)")
				XCTAssertNotNil(firstUserData.id)
				XCTAssertNotNil(firstUserData.glucoseLevel)
				XCTAssertNotNil(firstUserData.riskStatus)
				XCTAssertNotNil(firstUserData.timestamp)
			}

		case .failure(let error):
			print("Error occurred:", error)
			XCTFail("Expected success, but got failure with error: \(error)")

		case .none:
			print("No response received")
			XCTFail("Expected result, but got none")
		}
	}

	func testInvalidEndpoint_shouldReturnNotFoundError() {
		let getUserDataRequest = RequestType.customRequest(endpoint: "/nonexistent-endpoint", httpMethod: .get)

		logInfo("Testing with modified endpoint: \(getUserDataRequest)")

		let result = sendRequest(getUserDataRequest, responseType: [TestUserDataModel].self)
		logInfo("Received result: \(String(describing: result))")

		if case .failure(let error) = result, error == .notFound {
			logSuccess("Test passed: Received expected 404 error - \(error)")
			XCTAssertEqual(error, .notFound)
		} else {
			XCTFail("Expected .notFound error, but got \(String(describing: result))")
		}
	}

	func testQueryParamsTest() {
		let jsonData = loadMockData(from: "validUserData")
		XCTAssertNotNil(jsonData, "Expected non-nil JSON data")
		guard let jsonData = jsonData else {
			return
		}

		mockSession.data = jsonData

		var request = RequestType.getGlucoseDataRequest
		request.setQueryParam("id", value: "9425975892")
		logInfo("Testing with: \(request)")

		let result = sendRequest(request, responseType: [TestGlucoseDataModel].self)
		logInfo("Received result: \(String(describing: result))")

		guard let result = result else {
			XCTFail("Expected result to be non-nil")
			return
		}

		let expectedData = [TestGlucoseDataModel(id: "9425975892", glucoseLevel: 152, riskStatus: "borderline", timestamp: "2024-03-22T01:37:43Z")]

		if case .success(let actualData) = result {
			XCTAssertEqual(actualData, expectedData, "Actual data does not match the expected data")
			print(actualData, "<--actual data and expected data -->", expectedData)
			logSuccess("Successfully decoded and matched actual data with expected data from validUserData.json")
		} else if case .failure(let error) = result {
			XCTFail("Expected success, but got error: \(error)")
		}
	}

	func testDirectDecoding() {
		guard let data = loadMockData(from: "validUserData") else {
			XCTFail("Failed to load data from validUserData.json")
			return
		}

		do {
			let decodedData = try JSONDecoder().decode(TestUserDataModel.self, from: data)
			print("Decoded data:", decodedData)
		} catch {
			XCTFail("Direct decoding failed with error: \(error)")
		}
	}

	func testUserDataDecoding() {
		guard let data = loadMockData(from: "validUserData") else {
			XCTFail("Failed to load data from validUserData.json")
			return
		}

		do {
			let decodedData = try JSONDecoder().decode(TestUserDataModel.self, from: data)
			print("Decoded TestUserDataModel:", decodedData)
		} catch {
			XCTFail("Decoding TestUserDataModel failed with error: \(error)")
		}
	}

	

	func testInvalidJSONResponse_shouldReturnDecodingError() {
		guard let invalidJsonData = loadMockData(from: "invalidUserData") else {
			XCTFail("Failed to load data from invalidUserData.json")
			return
		}

		mockSession.data = invalidJsonData

		let request = RequestType.getUserRequest
		logInfo("Testing with request: \(request) and invalid JSON data")

		let result = sendRequest(request, responseType: TestUserDataModel.self)
		logInfo("Received result: \(String(describing: result))")

		guard let result = result else {
			XCTFail("Expected result to be non-nil")
			return
		}

		let expectedError = APIError.decodingError

		if case .failure(let actualError) = result {
			XCTAssertEqual(actualError, expectedError, "Expected decoding error, but got \(actualError) instead")
			logSuccess("Test passed: Received expected decoding error")
		} else if case .success(let decodedData) = result {
			XCTFail("Expected decoding error, but got success with data: \(decodedData)")
		}
	}
	
}
