//
//  ImageDownloader.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import UIKit

struct ImageDownloader {

	static func downloadImageByURL(urlString: String, complition: (UIImage) -> ()) {

		if let url = NSURL(string: urlString) {
			let downloadTask = NSURLSession.sharedSession().downloadTaskWithURL(url) {
				location, response, error in
				
				if nil == error, let location = location,
					let imageData = NSData(contentsOfURL: location),
					let image = UIImage(data: imageData) {

					dispatch_async(dispatch_get_main_queue()) {
						complition(image)
					}
				}
			}

			downloadTask.resume()
		}
	}

}
