//
//  CurrentUserHeaderView.swift
//  GithubFollowers
//
//  Created by Ди on 23.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import UIKit

class CurrentUserHeaderView: UIView {

	@IBOutlet weak var avatarImageView: AvatarView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var htmlURLLabel: UILabel!
	
	class func headerView() -> CurrentUserHeaderView {

		let view = NSBundle.mainBundle().loadNibNamed("CurrentUserHeaderView", owner: self, options: nil).first as! CurrentUserHeaderView
		view.backgroundColor = UIColor.standartLightBlueColor()

		return view
	}

	func configureWithUser(user: User) {

		titleLabel.text = user.login
		htmlURLLabel.text = user.htmlURL

		if let avatarURL = user.avatarURL {
			FlyweightImageFactory.getImageWithURL(avatarURL, complition: { [weak self] image in
				self?.avatarImageView.image = image
				})
		} else {
			avatarImageView.image = UIImage(named: "avatar")
		}
	}

	class func standartHeight() -> CGFloat {

		return 200.0
	}

	func animate() {
		
		avatarImageView.transform = CGAffineTransformMakeScale(0.5, 0.5)

		UIView.animateWithDuration(2.0, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0,
			options: [], animations: { [weak self] in
				self?.avatarImageView.transform = CGAffineTransformIdentity
			}, completion: nil)
	}

}
