//
//  FlyweightImageFactory.swift
//  DUSwipeBank
//
//  Created by Ди on 23.07.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import UIKit

struct FlyweightImageFactory {
	
	private static var imageDictionary = [String : UIImage]()

	static func getImageWithURL(imageURL: String, complition: (UIImage) -> ()) {
		
		if let existingImage = imageDictionary[imageURL] {
			complition(existingImage)
		} else {
			ImageDownloader.downloadImageByURL(imageURL) {
				downloadedImage in

				imageDictionary[imageURL] = downloadedImage
				complition(downloadedImage)
			}
		}
	}

	static func drainFactory() {

		imageDictionary = [String : UIImage]()
	}

}