//
//  DetailViewController.swift
//  GithubUsers
//
//  Created by Ди on 21.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import UIKit

class FollowersViewController: BaseUsersTableViewController {


	lazy var interactor: FollowersInteractorInput = {

		let interactor = FollowersInteractor()
		interactor.output = self
		return interactor
	}()

	var headerView: CurrentUserHeaderView = {

		return CurrentUserHeaderView.headerView()
	}()
	
	var detailUser: User!

	override var users: [User] {
		get {
			return detailUser.followers ?? [User]()
		}
		set {
			detailUser.followers = newValue
		}
	}

	var followers: [User]? {

		return detailUser.followers
	}

	// MARK: Life Circle

	override func viewDidLoad() {

		super.viewDidLoad()

		navigationItem.title = "Followers"
		loadHeaderView()
	}

	override func viewWillAppear(animated: Bool) {

		super.viewWillAppear(animated)

		headerView.animate()
	}

	// MARK: Overriden Methods
	
	override func loadUsers() {

		interactor.loadFollowersForUser(detailUser)
	}

	override func canLoadNextPage() -> Bool {

		return interactor.canLoadNextPage()
	}

	// MARK: Private methods

	private func loadHeaderView() {

		headerView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.frame.width,
			height: CurrentUserHeaderView.standartHeight()))

		headerView.configureWithUser(detailUser)

		tableView.tableHeaderView = headerView
	}

}

