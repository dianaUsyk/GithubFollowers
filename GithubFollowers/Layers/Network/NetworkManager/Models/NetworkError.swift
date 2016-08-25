//
//  NetworkError.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

enum NetworkErrorCode: Int {
	case JSONSerializationError = -5001
	case ResponseDataEmpty = -5002
	case ServerSideErrorMessage = -5003
	case StatusCodeValidationFailed = -5004
}

struct NetworkError {

	static let ErrorDomain : String = "DU.GithubUsers.networkError"

	static func defaultNetworkError() -> NSError {

		return NSError(domain: ErrorDomain, code: 1, userInfo: nil)
	}

	static func errorWithCode(code: NetworkErrorCode, failureReason: String) -> NSError {

		let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]

		return NSError(domain: ErrorDomain, code: code.rawValue, userInfo: userInfo)
	}

}