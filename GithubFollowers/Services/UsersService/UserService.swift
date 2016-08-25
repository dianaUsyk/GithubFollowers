//
//  UserService.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

class UserService: UserServiceInterface {

	let apiClient = UsersAPIClient()

	func getGithubUsers(sinceUserID: String, complition: (users: [User]?, linkContainer: GithubLinkContainer?, error: ErrorType?) -> Void) {

		apiClient.getGithubUsers(sinceUserID, completionHandler: complition)
	}

	func getFollowers(page: String, followersURL: String, complition: (users: [User]?, linkContainer: GithubLinkContainer?, error: ErrorType?) -> Void) {

		apiClient.getFollowers(page, followersURL: followersURL, completionHandler: complition)
	}
	
}
