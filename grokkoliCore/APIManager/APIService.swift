import Foundation

extension URLRequest {
	mutating func setHeaders(_ headers: [Headers: String]) {
		for headers in headers {
			setValue(headers.value, forHTTPHeaderField: headers.key.rawValue)
		}
	}
}

class APIService {
	let logger = LoggerManager.shared

	let baseURL: URL? = URL(string: "https://my-json-server.typicode.com/jnesterov/grokAPI")

	// computed property for testing access
	var testableBaseURL: URL {
		return baseURL ?? URL(string: "https://fallback.url")!
	}

	func createRequest(from apiRequest: APIRequest) -> URLRequest? {
		let baseURL = testableBaseURL

		var urlComponents = URLComponents(url: baseURL.appendingPathComponent(apiRequest.endpoint), resolvingAgainstBaseURL: true)
		urlComponents?.queryItems = apiRequest.queryParams?.map { URLQueryItem(name: $0.key, value: $0.value) }

		guard let url = urlComponents?.url else {
			return nil
		}

		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = apiRequest.httpMethod.rawValue

		if let headers = apiRequest.headers {
			urlRequest.setHeaders(headers)
		}

		if let body = apiRequest.body {
			urlRequest.httpBody = body
		}

		if let contentType = apiRequest.contentType {
			urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
		}

		return urlRequest
	}

	func sendRequest<T: Decodable>(_ apiRequest: APIRequest, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
		guard let urlRequest = createRequest(from: apiRequest) else {
			logError("Failed to create URLRequest from APIRequest")
			completion(.failure(APIError.badRequest))
			return
		}

		URLSession.shared.dataTask(with: urlRequest) { data, response, error in

			if error != nil {
				completion(.failure(APIError.serviceUnavailable))
				return
			}

			guard let httpResponse = response as? HTTPURLResponse else {
				logWarning("Received non-HTTP response")
				completion(.failure(.unknown))
				return
			}
			print("Received HTTP status code: \(httpResponse.statusCode)")

			if !(200 ... 299).contains(httpResponse.statusCode) {
				let apiError = APIError.fromStatusCode(httpResponse.statusCode)

				logWarning("HTTP error with status code \(httpResponse.statusCode), mapped to APIError: \(apiError)")
				completion(.failure(apiError))
				return
			}

			guard let data = data else {
				logError("No data received in response")
				completion(.failure(APIError.noData))
				return
			}

			do {
				let decodedData = try JSONDecoder().decode(T.self, from: data)
				completion(.success(decodedData))
			} catch {
				logError("Decoding error: \(error.localizedDescription)")
				completion(.failure(.decodingError))
			}
		}.resume()
	}

	func decodeResponse<T: Decodable>(_ decodedData: Data, as type: T.Type) throws -> T {
		return try JSONDecoder().decode(T.self, from: decodedData)
	}

	enum Errors: String, Error {
		case noData = "no data"
		case unknown
	}
}
