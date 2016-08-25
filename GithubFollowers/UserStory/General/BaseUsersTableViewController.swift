//
//  BaseUsersTableViewController.swift
//  GithubFollowers
//
//  Created by Ди on 23.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import UIKit

class BaseUsersTableViewController : UITableViewController, BaseUsersInteractorOutput {

	var users: [User] = [User]()

	var loaderFooterView: LoaderFooterView = {

		return LoaderFooterView.footerView()
	}()

	override func viewDidLoad() {

		super.viewDidLoad()

		setupInitialState()
	}

	override func didReceiveMemoryWarning() {

		super.didReceiveMemoryWarning()

		FlyweightImageFactory.drainFactory()
	}

	// MARK: BaseUsersInteractorOutput

	func usersInteractorDidLoadUsers(interactor: BaseUsersInteractorInput, users: [User]) {

		let lastRow = self.users.count - 1

		let existingUserIDs = self.users.map{ $0.userID }

		let substruct = users.filter { !existingUserIDs.contains($0.userID) }

		self.users += substruct

		var indexPaths = [NSIndexPath]()

		for index in 0..<substruct.count {
			indexPaths.append(NSIndexPath(forRow: index + lastRow, inSection: 0))
		}

		loadingFooterViewHidden(true)
		self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
	}

	// MARK: - Table View

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return users.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as!
		UserTableViewCell

		let user = users[indexPath.row]
		cell.configureWithUser(user)

		return cell
	}

	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

		return UserTableViewCell.cellHeight()
	}

	override func scrollViewDidScroll(scrollView: UIScrollView) {

		let offsetY = scrollView.contentOffset.y
		let height = scrollView.contentSize.height - tableView.bounds.height

		if canLoadNextPage() && offsetY > height {
			loadUsers()
			loadingFooterViewHidden(false)
		}
	}

	// MARK: Abstract Methods

	func loadUsers() {

	}

	func canLoadNextPage() -> Bool {

		return false
	}

	// MARK: Private Methods

	private func setupInitialState() {

		tableView.registerNib(UINib.init(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCell")
	}

	private func loadingFooterViewHidden(hidden: Bool) {

		if hidden == true && nil != tableView.tableFooterView {
			loaderFooterView.stopAnimating()
			tableView.tableFooterView = nil
		} else {
			loaderFooterView.startAnimating()
			loaderFooterView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.frame.width, height: LoaderFooterView.height()))
			tableView.tableFooterView = loaderFooterView
		}
	}
}
