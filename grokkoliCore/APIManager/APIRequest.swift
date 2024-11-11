import Foundation

protocol APIRequest {
	var endpoint: String { get }
	var httpMethod: HttpMethod { get }
	var headers: [Headers: String]? { get set }
	var body: Data? { get }
	var contentType: ContentType? { get }
	var queryParams: [String: String]? { get set }
}
