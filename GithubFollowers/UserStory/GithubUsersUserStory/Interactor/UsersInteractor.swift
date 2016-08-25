//
//  UsersInteractor.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

class UsersInteractor: BaseUserInteractor, UsersInteractorInput {

	// MARK: UsersInteractorInput

	func loadUsers() {

		isLoading = true
		let since = lastLinkContainer?.pagePerType[.Next] ?? 0
		
		userService.getGithubUsers("\(since)") {
			[weak self] (users, linkContainer, error) in

			self?.handleLoadedUsers(users, linkContainer: linkContainer, error: error)
		}
	}

}
