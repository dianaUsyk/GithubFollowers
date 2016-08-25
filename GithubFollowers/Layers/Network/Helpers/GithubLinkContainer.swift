//
//  GithubLinkContainer.swift
//  GithubFollowers
//
//  Created by Ди on 23.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

class GithubLinkContainer {

	var pagePerType = [LinkType : UInt]()
	var linkPerType = [LinkType : String]()

	enum LinkType: String {
		case Next = "next"
		case Prev = "prev"
		case First = "first"
		case Last = "last"
	}

	init(linkHeader: String?) {

		parse(linkHeader)
	}

	func parse(linkHeader: String!) {

		var result = [LinkType:UInt]()
		// <https://git.supinf.co/api/v3/projects/owned?page=1&per_page=0>; rel="prev", <https://git.supinf.co/api/v3/projects/followers?page=3&per_page=0>; rel="next", <https://git.supinf.co/api/v3/projects/followers?page=1&per_page=0>; rel="first", <https://git.supinf.co/api/v3/projects/followers?page=3&per_page=0>; rel="last"
		let links: [String] = linkHeader.trim().componentsSeparatedByString(",")
		for link in links {
			// <https://git.supinf.co/api/v3/projects/followers?page=1&per_page=0>; rel="prev"
			var section: [String] = link.trim().componentsSeparatedByString(";")
			if (section.count != 2) {
				print("invalid link string. \(section)")
			}

			let url: String = section[0].trim().stringByReplacingOccurrencesOfString("^<|>$", withString:"", options:NSStringCompareOptions.RegularExpressionSearch, range: nil)

			let type: LinkType = LinkType(rawValue: section[1].trim().stringByReplacingOccurrencesOfString("^rel=\"|\"$", withString:"", options:NSStringCompareOptions.RegularExpressionSearch, range: nil))!

			linkPerType[type] = url

			if let urlObj = NSURLComponents(string: url), let queryItems = urlObj.queryItems {
				for i in 0..<queryItems.count {
					let item = queryItems[i] as NSURLQueryItem
					if let value = item.value {
						if item.name == "page" || item.name == "since" {
							result[type] = UInt(value)
							break
						}
					}
				}
			}
		}

		pagePerType = result
	}

}

