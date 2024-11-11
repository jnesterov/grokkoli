import Foundation

enum HttpMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}

enum APIError: Error, CustomStringConvertible {
	case badRequest
	case unauthorized
	case forbidden
	case notFound
	case requestTimeout
	case internalServerError
	case badGateway
	case serviceUnavailable
	case decodingError
	case unknown
	case noData

	var description: String {
		switch self {
		case .badRequest: return "Bad Request 400"
		case .unauthorized: return "Unauthorized 401"
		case .forbidden: return "Forbidden 403"
		case .notFound: return "Not Found 404"
		case .requestTimeout: return "Request Timeout 408"
		case .internalServerError: return "Internal Server Error 500"
		case .badGateway: return "Bad Gateway 502"
		case .serviceUnavailable: return "Service Unavailable 503"
		case .decodingError: return "Decoding Error"
		case .unknown: return "Unknown Error"
		case .noData: return "No Data"
		}
	}

	static func fromStatusCode(_ statusCode: Int) -> APIError {
		print("Mapping status code \(statusCode) to APIError")
		switch statusCode {
		case 400: return .badRequest
		case 401: return .unauthorized
		case 403: return .forbidden
		case 404: return .notFound
		case 408: return .requestTimeout
		case 500: return .internalServerError
		case 502: return .badGateway
		case 503: return .serviceUnavailable
		default: return .unknown
		}
	}
}

enum ContentType: String, CustomStringConvertible {
	case applicationJson = "application/json"
	case applicationXml = "application/xml"
	case formURLEncoded = "application/x-www-form-urlencoded"
	var description: String {
		return self.rawValue
	}
}

enum AcceptContentType: String, CustomStringConvertible {
	case applicationJson = "application/json"
	case applicationXml = "application/xml"
	case formURLEncoded = "application/x-www-form-urlencoded"

	var description: String {
		return self.rawValue
	}
}

enum AuthorizationHeader: CustomStringConvertible {
	case bearer(token: String)
	case basic(token: String)
	case oauth(token: String)
	case oauth2(token: String)

	var description: String {
		switch self {
		case .bearer(let token),
		     .oauth(let token),
		     .oauth2(let token):
			return "Bearer \(token)"
		case .basic(let token):
			return "Basic \(token)"
		}
	}
}

enum Headers: String, CustomStringConvertible {
	case accept = "Accept"
	case authorization = "Authorization"
	case connection = "Connection"
	case date = "Date"
	case host = "Host"
	case proxyAuthorization = "Proxy-Authorization"
	case transferEncoding = "Transfer-Encoding"

	var description: String {
		return self.rawValue
	}
}

enum StatusCode: Int, Error, CustomStringConvertible {
	case ok = 200
	case created = 201
	case accepted = 202
	case noContent = 204
	case movedPermanently = 301
	case notModified = 304
	case badRequest = 400
	case unauthorized = 401
	case forbidden = 403
	case notFound = 404
	case requestTimeout = 408
	case internalServerError = 500
	case badGateway = 502
	case serviceUnavailable = 503

	var description: String {
		return "Status Code: \(self.rawValue) - \(self.statusMessage)"
	}

	private var statusMessage: String {
		switch self {
		case .ok: return "OK"
		case .created: return "Created"
		case .accepted: return "Accepted"
		case .noContent: return "No Content"
		case .movedPermanently: return "Moved Permanently"
		case .notModified: return "Not Modified"
		case .badRequest: return "Bad Request"
		case .unauthorized: return "Unauthorized"
		case .forbidden: return "Forbidden"
		case .notFound: return "Not Found"
		case .requestTimeout: return "Request Timeout"
		case .internalServerError: return "Internal Server Error"
		case .badGateway: return "Bad Gateway"
		case .serviceUnavailable: return "Service Unavailable"
		}
	}
}
