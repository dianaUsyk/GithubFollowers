//
//  UsersAPIClient.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

class UsersAPIClient {

	let networkManager = NetworkManager()

	func getGithubUsers(sinceUserID: String, completionHandler: (users: [User]?, linkContainer: GithubLinkContainer?,
		error: ErrorType?) -> ()) {

		let githubUsersResource = UsersResource.Users(parameters: ["since" : sinceUserID])
		getUsers(githubUsersResource, completionHandler: completionHandler)
	}

	func getFollowers(page: String, followersURL: String, completionHandler: (users: [User]?, linkContainer: GithubLinkContainer?, error: ErrorType?) -> ()) {

		let githubUsersResource = UsersResource.Followers(followersURL: followersURL, parameters: ["page" : page])
		getUsers(githubUsersResource, completionHandler: completionHandler)
	}

	private func getUsers(resource: UsersResource, completionHandler: (users: [User]?, linkContainer: GithubLinkContainer?,
		error: ErrorType?) -> ()) {

		networkManager.resumeRequestWithResource(resource) { (response, error) in

			guard nil == error else {

				dispatch_async(dispatch_get_main_queue(), {
					completionHandler(users: nil, linkContainer: nil, error: error!)
				})

				return
			}

			do {

				let value = try response.JSONValue()
				guard let unwrappedValue = value as? [[String : AnyObject]] else {
					return
				}
				var linkContainer: GithubLinkContainer?
				if let linkHeader = response.HTTPHeaderFields()?["Link"] as? String {
					linkContainer = GithubLinkContainer(linkHeader: linkHeader)
				}

				let mappedUsers = unwrappedValue.map{ return User(serverResponce: $0) }

				dispatch_async(dispatch_get_main_queue(), {
					completionHandler(users: mappedUsers, linkContainer: linkContainer, error: nil)
				})

			} catch (let error){

				dispatch_async(dispatch_get_main_queue(), {
					completionHandler(users: nil, linkContainer: nil, error: error)
				})
			}
		}
	}

}