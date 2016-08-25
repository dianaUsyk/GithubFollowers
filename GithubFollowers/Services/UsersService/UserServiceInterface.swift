//
//  UserServiceInterface.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

protocol UserServiceInterface {

	func getGithubUsers(sinceUserID: String, complition: (users: [User]?, linkContainer: GithubLinkContainer?,
		error: ErrorType?) -> Void)
	
	func getFollowers(page: String, followersURL: String, complition: (users: [User]?, linkContainer: GithubLinkContainer?, error: ErrorType?) -> Void)
	
}