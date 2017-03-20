//
//  Store.swift
//  SharedWebCredentials
//
//  Created by Sam Soffes on 3/20/17.
//  Copyright © 2017 Sam Soffes. All rights reserved.
//

import Security

///
/// Shared Web Credentials Store.
///
/// Supports reading, adding, and removing shared web credentials. There is also a utility method for generating a new
/// password.
///
public struct Store {

	// MARK: - Types

	///
	/// Completion block for reading from shared web credentials.
	///
	/// - note: If the error is `nil`, the array will not be empty.
	///
	/// - parameter credentials: Array of credentials or `nil`.
	/// - parameter error: System error or `nil`.
	///
	public typealias ReadCompletion = (_ credential: Credential?, _ error: CFError?) -> Void

	///
	/// Completion block for writing to shared web credentials.
	///
	/// - note: If the error is `nil`, the operation was a success.
	///
	/// - parameter error: System error or `nil`.
	///
	public typealias WriteCompletion = (_ error: CFError?) -> Void


	// MARK: - Accessing Shared Web Credentials

	///
	/// Asynchronously obtain one or more shared passwords for a website.
	///
	/// This function requests one or more shared passwords for a given website, depending on whether the optional
	/// account parameter is supplied. To obtain results, the website specified in the fqdn parameter must be one which
	/// matches an entry in the calling application’s `com.apple.developer.associated-domains` entitlement.
	///
	/// - Note:
	///
	/// The system API `SecRequestSharedWebCredential` returns an array of `CFDictionary` objects for each result. In
	/// practice, you only ever get one dictionary in this array. The system UI shows all of the credentials you have
	/// saved, but makes you select just one. The one you select is the contents of the results array.
	///
	/// - Parameters:
	///
	///     - domain: Fully qualified domain name of the website for which passwords are being requested. If `nil` is
	///               passed in this argument, the domain name(s) listed in the calling application’s
	///               `com.apple.developer.associated-domains` entitlement are searched implicitly.
	///
	///     - account: Account name for which passwords are being requested. The account may be `nil` to request all
	///                shared credentials which are available for the site, allowing the caller to discover an existing
	///                account.
	///
	///     - completion: A block which will be called to deliver the requested credential. If no matching items were
	///                   found, the credential array will be `nil`, and the CFErrorRef parameter will provide the
	///                   error result.
	///
	public static func get(domain: String? = nil, account: String? = nil, completion: @escaping ReadCompletion) {
		let cfDomain = domain.flatMap { $0 as CFString }
		let cfAccount = account.flatMap { $0 as CFString }

		SecRequestSharedWebCredential(cfDomain, cfAccount) { array, error in
			let credential: Credential?

			if let array = array as Array?, let dictionary = array.first as? NSDictionary {
				credential = Credential(dictionary: dictionary)
			} else {
				credential = nil
			}

			completion(credential, error)
		}
	}

	///
	/// Asynchronously store (or update) a shared password for a website.
	///
	/// This function adds a shared password item which will be accessible by Safari and applications that have the
	/// specified fully-qualified domain name in their `com.apple.developer.associated-domains` entitlement. If a shared
	/// password item already exists for the specified website and account, it will be updated with the provided
	/// password.
	///
	/// - Note:
	///
	///     Since a request involving shared web credentials may potentially require user interaction or other
	///     verification to be approved, this function is dispatched asynchronously; your code provides a completion
	///     handler that will be called once the results (if any) are available.
	///
	/// - Parameters:
	///
	///     - domain: The fully qualified domain name of the website requiring the password.
	///
	///     - account: The account name associated with this password.
	///
	///     - password: The password to be stored.
	///
	///     - completion: A block which will be invoked when the function has completed. If the shared password was
	///                   successfully added, the CFErrorRef parameter passed to the block will be `nil`. If the error
	///                   parameter is non-nil, an error occurred and the error reference will hold the result.
	///
	///
	public static func add(domain: String, account: String, password: String, completion: WriteCompletion? = nil) {
		SecAddSharedWebCredential(domain as CFString, account as CFString, password as CFString) { error in
			completion?(error)
		}
	}

	///
	/// Asynchronously remove a shared password for a website.
	///
	/// This function remove a shared password item which will be accessible by Safari and applications that have the
	/// specified fully-qualified domain name in their `com.apple.developer.associated-domains` entitlement.
	///
	/// - Note:
	///
	///     Since a request involving shared web credentials may potentially require user interaction or other
	///     verification to be approved, this function is dispatched asynchronously; your code provides a completion
	///     handler that will be called once the results (if any) are available.
	///
	/// - Parameters:
	///
	///     - domain: The fully qualified domain name of the website requiring the password.
	///
	///     - account: The account name associated with this password.
	///
	///     - completion: A block which will be invoked when the function has completed. If the shared password was
	///                   successfully removed, the CFErrorRef parameter passed to the block will be `nil`. If the error
	///                   parameter is non-nil, an error occurred and the error reference will hold the result.
	///
	///
	public static func remove(domain: String, account: String, completion: WriteCompletion? = nil) {
		SecAddSharedWebCredential(domain as CFString, account as CFString, nil) { error in
			completion?(error)
		}
	}


	// MARK: - Generating Passwords

	///
	/// Returns a randomly generated password.
	///
	/// - Returns:
	///
	///     Optional `String` password in the form `xxx-xxx-xxx-xxx` where `x` is taken from the sets
	///     `"abcdefghkmnopqrstuvwxy"`, `"ABCDEFGHJKLMNPQRSTUVWXYZ"`, `"3456789"` with at least one character from each
	///     set being present or `nil` if it failed.
	///
	public static func generatePassword() -> String? {
		return SecCreateSharedWebCredentialPassword() as String?
	}
}
