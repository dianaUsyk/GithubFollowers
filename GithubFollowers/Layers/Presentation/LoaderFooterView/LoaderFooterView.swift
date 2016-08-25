//
//  LoaderFooterView.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import UIKit

class LoaderFooterView: UIView {

	@IBOutlet weak var spinnerView: UIActivityIndicatorView!

	static func footerView() -> LoaderFooterView {

		let view = NSBundle.mainBundle().loadNibNamed("LoaderFooterView", owner: self, options: nil).first as! LoaderFooterView

		return view
	}

	func stopAnimating() {

		spinnerView.stopAnimating()
	}

	func startAnimating() {

		spinnerView.startAnimating()
	}

	static func height() -> CGFloat {

		return 40.0
	}
}