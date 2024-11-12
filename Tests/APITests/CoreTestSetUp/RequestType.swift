import Foundation
@testable import grokkoli

class RequestType {
	static var getUserRequest: GetUserRequest {
		return GetUserRequest()
	}
    
	static var createUserRequest: PostRequest {
		return PostRequest(endpoint: "/users", httpMethod: .post)
	}
    
	static var updateUserRequest: PutRequest {
		return PutRequest(endpoint: "/users/update", httpMethod: .put)
	}
    
	static var deleteUserRequest: DeleteRequest {
		return DeleteRequest(endpoint: "/users/delete", httpMethod: .delete)
	}

	static var getGlucoseDataRequest: GlucoseDataRequest {
		return GlucoseDataRequest(endpoint: "/glucoseData", httpMethod: .get)
	}
    
	static var postGlucoseDataRequest: PostRequest {
		return PostRequest(endpoint: "/glucoseData", httpMethod: .post)
	}
    
	static var putGlucoseDataRequest: PutRequest {
		return PutRequest(endpoint: "/glucoseData", httpMethod: .put)
	}
    
	static var deleteGlucoseDataRequest: DeleteRequest {
		return DeleteRequest(endpoint: "/glucoseData", httpMethod: .delete)
	}
    
	struct GetUserRequest: APIRequest {
		var endpoint: String = "/users"
		var httpMethod: HttpMethod = .get
		var headers: [Headers: String]? = nil
		var body: Data? = nil
		var contentType: ContentType? = .applicationJson
		var queryParams: [String: String]? = nil
		
		mutating func setQueryParam(_ key: String, value: String) {
			if queryParams == nil {
				queryParams = [:]
			}
			queryParams?[key] = value
		}
	}
    
	struct PostRequest: APIRequest {
		var endpoint: String
		var httpMethod: HttpMethod = .post
		var headers: [Headers: String]? = nil
		var body: Data?
		var contentType: ContentType? = .applicationJson
		var queryParams: [String: String]?
	}
    
	struct PutRequest: APIRequest {
		var endpoint: String
		var httpMethod: HttpMethod = .put
		var headers: [Headers: String]? = nil
		var body: Data?
		var contentType: ContentType? = .applicationJson
		var queryParams: [String: String]?
	}
    
	struct DeleteRequest: APIRequest {
		var endpoint: String
		var httpMethod: HttpMethod = .delete
		var headers: [Headers: String]? = nil
		var body: Data? = nil
		var contentType: ContentType? = .applicationJson
		var queryParams: [String: String]?
	}

	struct GlucoseDataRequest: APIRequest {
		var endpoint: String
		var httpMethod: HttpMethod
		var headers: [Headers: String]? = nil
		var body: Data? = nil
		var contentType: ContentType? = .applicationJson
		var queryParams: [String: String]? = nil
		
		mutating func setQueryParam(_ key: String, value: String) {
			if queryParams == nil {
				queryParams = [:]
			}
			queryParams?[key] = value
		}
	}

	struct CustomRequest: APIRequest {
		var endpoint: String
		var httpMethod: HttpMethod
		var headers: [Headers: String]?
		var body: Data?
		var contentType: ContentType?
		var queryParams: [String: String]?
    
		init(endpoint: String, httpMethod: HttpMethod, headers: [Headers: String]? = nil, body: Data? = nil, contentType: ContentType? = nil, queryParams: [String: String]? = nil) {
			self.endpoint = endpoint
			self.httpMethod = httpMethod
			self.headers = headers
			self.body = body
			self.contentType = contentType
			self.queryParams = queryParams
		}
	}

	static func customRequest(endpoint: String, httpMethod: HttpMethod) -> CustomRequest {
		return CustomRequest(endpoint: endpoint, httpMethod: httpMethod, headers: nil, body: nil, contentType: nil, queryParams: nil)
	}
}
