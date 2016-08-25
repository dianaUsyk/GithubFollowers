//
//  DictionaryExtension.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

extension Dictionary {

	func merge (dictionary: [Key : Value]) -> [Key : Value] {
		
		var mutableCopy = self

		for (key, value) in dictionary {
			mutableCopy[key] = value
		}

		return mutableCopy
	}
}
