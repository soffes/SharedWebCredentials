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

Get registered credentials:

``` swift
Store.get { credentials, error in
    if let error = error {
        print("Something went wrong: \(error)")
    }

    for credential in credentials {
        print("Username: \(credential.account), Password: \(credential.password)")
    }
}
```

Add a new password:

``` swift
Store.add(domain: "myapp.com", account: "steve", password: "password")
```

Remove a password:

``` swift
Store.remove(domain: "myapp.com", account: "steve")
```
