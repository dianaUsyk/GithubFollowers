//
//  BaseUsersInteractorIO.swift
//  GithubFollowers
//
//  Created by Ди on 23.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

protocol BaseUsersInteractorInput  {

	weak var output: BaseUsersInteractorOutput? { get set }

	func canLoadNextPage() -> Bool

}

protocol BaseUsersInteractorOutput: class {

	func usersInteractorDidLoadUsers(interactor: BaseUsersInteractorInput, users: [User])

}