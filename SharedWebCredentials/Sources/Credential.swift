//
//  Credential.swift
//  SharedWebCredentials
//
//  Created by Sam Soffes on 3/20/17.
//  Copyright © 2017 Sam Soffes. All rights reserved.
//

/// Single credential from Shared Web Credentials Store.
public struct Credential {

	/// Fully qualified domain name of the website
	public let domain: String

	/// Account name
	public let account: String

	/// Password
	public let password: String

	/// Initialize with a result from the Store
	init?(dictionary: NSDictionary) {
		let dict = dictionary as Dictionary

		guard let domain = dict[kSecAttrServer] as? String,
			let account = dict[kSecAttrAccount] as? String,
			let password = dict[kSecSharedPassword] as? String
		else { return nil }

		self.domain = domain
		self.account = account
		self.password = password
	}
}
