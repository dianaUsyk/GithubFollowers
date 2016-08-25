//
//  UserTableViewCell.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

	@IBOutlet weak var avatarImageView: AvatarView!
	@IBOutlet weak var loginLabel: UILabel!
	@IBOutlet weak var htmlURLLabel: UILabel!

	override func awakeFromNib() {

		super.awakeFromNib()

		let bgColorView = UIView()
		bgColorView.backgroundColor = UIColor.standartLightBlueColor()
		selectedBackgroundView = bgColorView
	}

	func configureWithUser(user: User) {

		loginLabel.text = user.login
		htmlURLLabel.text = user.htmlURL

		avatarImageView.image = nil

		if let avatarURL = user.avatarURL {
			FlyweightImageFactory.getImageWithURL(avatarURL, complition: { [weak self] image in
				self?.avatarImageView.image = image
			})
		}
		else {
			self.avatarImageView.image = UIImage(named: "avatar")
		}
	}

	func showDisclosureIndicator() {

		accessoryType = .DisclosureIndicator
	}

	class func cellHeight() -> CGFloat {
		
		return 120.0
	}
}
