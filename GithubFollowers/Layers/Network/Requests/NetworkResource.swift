//
//  NetworkResource.swift
//  GithubUsers
//
//  Created by Ди on 22.08.16.
//  Copyright © 2016 DianaUsyk. All rights reserved.
//

import Foundation

protocol NetworkResource {

	var baseURL: NSURL {get}
	var path: String {get}
	var parameters: [String: AnyObject]? {get}
	var method: RequestMethod {get}
	var authParameters: [String : AnyObject] { get }
	
}

extension NetworkResource {

	var authParameters: [String : AnyObject] {
		return ["client_id" : "f13d1a739d4a39513d94", "client_secret" : "bb88b4ffa55006158fe450820807007e7c317ce5"]
	}

}