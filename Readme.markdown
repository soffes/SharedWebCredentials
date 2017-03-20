# SharedWebCredential

[![Version](https://img.shields.io/github/release/soffes/SharedWebCredential.svg)](https://github.com/soffes/SharedWebCredential/releases)
![Swift Version](https://img.shields.io/badge/swift-3.0.2-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Swift library for easily working with Shared Web Credentials for iOS with [Carthage](https://github.com/carthage/carthage) support.

Released under the [MIT license](LICENSE). Enjoy.


## Installation

[Carthage](https://github.com/carthage/carthage) is the recommended way to install SharedWebCredential. Add the following to your Cartfile:

``` ruby
github "soffes/SharedWebCredential"
```

## Usage
Start by importing the framework:

``` swift
import SharedWebCredential
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
