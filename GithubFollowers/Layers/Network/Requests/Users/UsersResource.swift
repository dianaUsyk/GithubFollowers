//
//  UsersResource.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

enum UsersResource {
	case Users (parameters: [String : AnyObject]?)
	case Followers(followersURL: String, parameters: [String : AnyObject]?)
}

extension UsersResource: NetworkResource {

	var githubURL: String {

		return "https://api.github.com"
	}

	var baseURL: NSURL {

		let urlString: String
		switch self {
			case Users:
				urlString = githubURL
			case Followers(let url, _):
				urlString = url
		}

		return NSURL(string: urlString)!
	}

	var path: String {

		switch self {
			case Users:
				return "/users"
			case Followers:
				return ""
		}
	}

	var parameters: [String : AnyObject]? {
		switch self {
			case Users (let parameters):
				return parameters
			case Followers(_, let parameters):
				return parameters
		}
	}

	var method: RequestMethod {
		switch self {
			case Users, Followers:
				return .GET
			}
	}
}