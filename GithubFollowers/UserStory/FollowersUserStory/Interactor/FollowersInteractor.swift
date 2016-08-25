//
//  FollowersInteractor.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

class FollowersInteractor: BaseUserInteractor, FollowersInteractorInput {

	// MARK: FollowersInteractorInput

	func loadFollowersForUser(user: User) {

		isLoading = true

		if let followersURL = user.followersUrl {
			let nextPage = lastLinkContainer?.pagePerType[.Next] ?? 0
			userService.getFollowers("\(nextPage)", followersURL: followersURL) {
				[weak self] (users, linkContainer, error) in
				
				self?.handleLoadedUsers(users, linkContainer: linkContainer, error: error)
			}
		} else {
			notifyOutputAboutLoadedUsers([User]())
		}
	}

}