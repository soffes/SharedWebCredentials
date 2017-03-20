# SharedWebCredentials

[![Version](https://img.shields.io/github/release/soffes/SharedWebCredentials.svg)](https://github.com/soffes/SharedWebCredentials/releases)
![Swift Version](https://img.shields.io/badge/swift-3.0.2-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Swift library for easily working with Shared Web Credentials for iOS with [Carthage](https://github.com/carthage/carthage) support.

**[Read the documentation](https://soffes.github.io/SharedWebCredentials/).**

Released under the [MIT license](LICENSE). Enjoy.


## Installation

[Carthage](https://github.com/carthage/carthage) is the recommended way to install SharedWebCredentials. Add the following to your Cartfile:

``` ruby
github "soffes/SharedWebCredentials"
```


## Prerequisites

To use Shared Web Credentials, you’ll need to setup the proper entitlements and an associated domain. Here’s [documentation](https://developer.apple.com/reference/security/shared_web_credentials) on how to do that.

Be sure you don’t miss:

> If your app runs in iOS 9 and later and you use HTTPS to serve the file, you can create a plain text file that uses the application/json MIME type and you don’t need to sign it.

All of that signing stuff is a real pain. If you are targeting iOS 9 or later, you can skip this step!

Once you get all of that stuff setup, you can use this framework instead of the Security framework to access the credentials in a Swift-friendly way.


## Usage

Start by importing the framework:

``` swift
import SharedWebCredentials
```

### Retrieve Credentials

The system will show its own UI for letting the user choose which account they want to use to sign into the app. The result will be a `Credential` struct or `nil`.

``` swift
Store.get { credential, error in
    if let credential = credential {
        print("Username: \(credential.account), Password: \(credential.password)")
    }

    print("Error: \(error)")
}
```

It will automatically use any of the domains you have set in your `com.apple.developer.associated-domains` entitlement. You can optionally specify the `domain` argument to pick a specific one.


### Adding a New Credential

``` swift
Store.add(domain: "myapp.com", account: "steve", password: "password")
```


### Removing a Credential

``` swift
Store.remove(domain: "myapp.com", account: "steve")
```

**[Read the full documentation](https://soffes.github.io/SharedWebCredentials/).**
