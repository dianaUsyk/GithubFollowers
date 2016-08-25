//
//  BaseUsersInteractor.swift
//  GithubFollowers
//
//  Created by Ди on 23.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

class BaseUserInteractor: BaseUsersInteractorInput {

	let userService: UserServiceInterface = UserService()

	weak var output: BaseUsersInteractorOutput?

	var isLoading = false
	var lastLinkContainer: GithubLinkContainer?

	// MARK: BaseUsersInteractorInput

	func canLoadNextPage() -> Bool {
		return !isLoading
	}

	// MARK: Base Methods

	func handleLoadedUsers(users: [User]?, linkContainer: GithubLinkContainer?, error: ErrorType?) {
		
		isLoading = false

		guard nil == error else {
			print("Error loading Users: \(error)")
			return
		}
		guard let users = users else {
			print("Any Users were loaded")
			return
		}
		
		lastLinkContainer = linkContainer

		let sortedUsers = users.sort{ $0.userID < $1.userID }
		notifyOutputAboutLoadedUsers(sortedUsers)
	}

	func notifyOutputAboutLoadedUsers(users: [User]) {

		output?.usersInteractorDidLoadUsers(self, users: users)
	}

}
