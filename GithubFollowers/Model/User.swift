//
//  User.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

class User: NSObject {

	var userID: Int64
	var login: String = ""
	var avatarURL: String?
	var htmlURL: String?
	var followersUrl: String?
	var followers: [User]?

	init(serverResponce: [String : AnyObject]) {

		userID = (serverResponce["id"] as? NSNumber)?.longLongValue ?? 0
		login = serverResponce["login"] as? String ?? ""
		avatarURL = serverResponce["avatar_url"] as? String
		htmlURL = serverResponce["html_url"] as? String
		followersUrl = serverResponce["followers_url"] as? String
	}
}