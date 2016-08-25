//
//  AvatarView.swift
//  GithubFollowers
//
//  Created by Ди on 23.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import UIKit

@IBDesignable
class AvatarView: UIView {

	let lineWidth: CGFloat = 6.0
	let photoLayer = CALayer()
	let circleLayer = CAShapeLayer()

	let maskLayer = CAShapeLayer()

	@IBInspectable
	var image: UIImage? {

		didSet {
			photoLayer.contents = image?.CGImage
			layoutIfNeeded()
		}
	}

	@IBInspectable
	var lineColor: UIColor = UIColor.standartLightBlueColor() {
		didSet {
			circleLayer.strokeColor = lineColor.CGColor
		}
	}

	override func didMoveToWindow() {

		layer.addSublayer(circleLayer)
		photoLayer.mask = maskLayer
		layer.addSublayer(photoLayer)
	}

	override func layoutSubviews() {

		//Size the avatar image to fit
		photoLayer.frame = bounds

		//Draw the circle
		circleLayer.path = UIBezierPath(ovalInRect: bounds).CGPath
		circleLayer.strokeColor = lineColor.CGColor
		circleLayer.lineWidth = lineWidth
		circleLayer.fillColor = UIColor.whiteColor().CGColor

		//Size the layer
		maskLayer.path = circleLayer.path
	}
}
