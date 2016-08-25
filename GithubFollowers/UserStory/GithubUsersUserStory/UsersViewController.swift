//
//  MasterViewController.swift
//  GithubUsers
//
//  Created by Ди on 21.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import UIKit

class UsersViewController: BaseUsersTableViewController {

	var detailViewController: FollowersViewController?

	lazy var interactor: UsersInteractorInput = {

		let interactor = UsersInteractor()
		interactor.output = self
		return interactor
	}()


	// MARK: - Segues

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

		if segue.identifier == "showDetail" {
			if let user = sender as? User {
				let controller = segue.destinationViewController  as! FollowersViewController
				controller.detailUser = user
				controller.navigationItem.leftItemsSupplementBackButton = true
			}
		}
	}

	// MARK: - Table View

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! UserTableViewCell
		cell.showDisclosureIndicator()

		return cell
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		performSegueWithIdentifier("showDetail", sender: users[indexPath.row])
	}

	// MARK: Overriden Methods
	
	override func loadUsers() {
		
		interactor.loadUsers()
	}

	override func canLoadNextPage() -> Bool {

		return interactor.canLoadNextPage()
	}

}

