//
//  NetworkManager.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

enum RequestMethod: String {
	case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

final class NetworkManager {

	private var session: NSURLSession!

	// MARK: Life Circle
	init() {

		let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
		session = NSURLSession(configuration: sessionConfiguration)
	}

	deinit {

		session.invalidateAndCancel()
	}

	// Public Methods

	func resumeRequestWithResource(networkResource: NetworkResource, complitionHandler: (response: Response,
		error: NSError?) -> ()) {
		
		guard let networkRequest = request(networkResource) else {
			return
		}

		let task = session.dataTaskWithRequest(networkRequest) { (data, responce, error) in
			guard let unwrappedData = data, let unwrappedResponse = responce else {
				return
			}

			let httpResponse = unwrappedResponse as? NSHTTPURLResponse
			let statusCode = httpResponse?.statusCode ?? 0

			let modelResponse = Response(statusCode: statusCode, data: unwrappedData, response: httpResponse)
			let validationResult = modelResponse.validateStatusCode()

			switch validationResult {
				case .Success:
					complitionHandler(response: modelResponse, error: nil)
				case .Failure(let error):
					complitionHandler(response: modelResponse, error: error)
					print("Failure: \(error.code)")
			}
		}

		task.resume()
	}

	// Private Methods

	private func request(networkResource: NetworkResource) -> NSMutableURLRequest? {

		guard var requestURL = NSURL(string: networkResource.path, relativeToURL: networkResource.baseURL) else {

			return nil
		}

		var allParameters = networkResource.authParameters
		if let parameters = networkResource.parameters {

			allParameters = allParameters.merge(parameters)
		}

		var URLString = requestURL.absoluteString + "?"

		allParameters.forEach({ (key, value) in
			URLString += ("\(key)=\(value)") + "&"
		})

		URLString = String(URLString.characters.dropLast())

		if let URL = NSURL(string: URLString) {
			requestURL = URL
		}

		let request = NSMutableURLRequest(URL: requestURL)
		request.HTTPMethod = networkResource.method.rawValue

		return request
	}

}