//
//  Response.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

final class Response {

	let statusCode: Int
	let data : NSData?

	private let URLResponse: NSHTTPURLResponse?

	init(statusCode: Int, data: NSData?, response: NSURLResponse?) {

		self.statusCode = statusCode
		self.data = data
		self.URLResponse = response as? NSHTTPURLResponse
	}
}

extension Response {

	enum ValidationResult {
		case Success
		case Failure(NSError)
	}

	func validateStatusCode() -> ValidationResult {

		let acceptableStatusCodes: Range<Int> = 200..<300
		if acceptableStatusCodes.contains(statusCode) {
			return .Success
		} else {
			return .Failure(NetworkError.errorWithCode(.StatusCodeValidationFailed, failureReason: "Response status code was unacceptable: \(statusCode)"))
		}
	}

	func HTTPHeaderFields() -> [String : AnyObject]? {

		return URLResponse?.allHeaderFields as? [String : AnyObject]
	}

}

extension Response {

	func JSONValue() throws -> AnyObject? {

		guard let data = data where data.length > 0  else {

			throw NetworkError.errorWithCode(.ResponseDataEmpty, failureReason: "Response data is empty")
		}

		do {
			let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
			
			return json
		} catch {
			throw NetworkError.errorWithCode(.JSONSerializationError, failureReason: "Not a json")
		}
	}
}

