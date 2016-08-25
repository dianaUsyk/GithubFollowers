//
//  FollowersInteractorIO.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

protocol FollowersInteractorInput: BaseUsersInteractorInput {

	func loadFollowersForUser(user: User)

}