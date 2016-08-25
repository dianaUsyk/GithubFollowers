//
//  StringExtension.swift
//  GithubFollowers
//
//  Created by Ди on 23.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

extension String {

	func trim() -> String {
		
		return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
	}

}