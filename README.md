<h1 align="center">SWMailgun</h1>

<p align="center">
 <a href="https://github.com/thejohnlima/SWMailgun/releases">
  <img src="https://img.shields.io/github/v/release/thejohnlima/SWMailgun?style=for-the-badge">
 </a>
 <a href="https://cocoapods.org/pods/SWMailgun">
  <img src="https://img.shields.io/badge/Cocoa%20Pods-✓-4BC51D.svg?style=for-the-badge">
 </a><br>
 <a href="https://github.com/thejohnlima/SWMailgun">
  <img src="https://img.shields.io/github/repo-size/thejohnlima/SWMailgun.svg?style=for-the-badge">
 </a>
 <a href="https://developer.apple.com/ios/">
  <img src="https://img.shields.io/cocoapods/p/SWMailgun?style=for-the-badge">
 </a>
 <a href="https://developer.apple.com/swift/">
  <img src="https://img.shields.io/badge/Swift-5-blue.svg?style=for-the-badge">
 </a>
 <a href="https://raw.githubusercontent.com/thejohnlima/SWMailgun/master/LICENSE">
  <img src="https://img.shields.io/github/license/thejohnlima/SWMailgun.svg?style=for-the-badge">
 </a>
</p>

**SWMailgun** provides a simple alternative when you need to send an email with your iOS app using MailGun.

## ❓ Why

Sometimes, there is the need to setup a simple email form in your iOS app, or to trigger an email after an action without having to setup your own service for that, sometimes you don't want to use the `MailComposeViewController` or use a `SMTP` library.
This provide a simple alternative when you need to send an email with your iOS app.

## ✉️ Mailgun

[Mailgun](https://mailgun.com) provides a simple reliable API for transactional emails. You will need to have an `ApiKey` and an account to use the client.

## ❗️ Requirements

- iOS 9.3+
- Swift 5.0+

## ⚒ Installation

### Swift Package Manager

**SWMailgun** is available through [SPM](https://developer.apple.com/videos/play/wwdc2019/408/). To install
it, follow the steps:

```script
Open Xcode project > File > Swift Packages > Add Package Dependecy
```

After that, put the url in the field: `https://github.com/thejohnlima/SWMailgun.git`

### CocoaPods

**SWMailgun** is available through [CocoaPods](https://cocoapods.org/pods/SWMailgun). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SWMailgun'
```

and run `pod install`

## 🎓 How to use

Usage is very simple

```Swift
// MARK: - Example using html string

import SWMailgun

let service = MailgunService()
let html = "<b>Test</b>"

let email = MailgunEmail(
    from: "Excited User <hello.world@email.com>",
    to: "mock@test.com",
    subject: "This is a test",
    html: html
)

let auth = MailgunAuth(
    domain: "YOUR_DOMAIN",
    apiKey: "YOUR_API_KEY"
)

service.send(email: email, auth: auth) { result, error in
    guard let result = result else {
        print("Error: \(error)")
        return
    }
    print("Email was sent: \(result.isSent())")
}
```

```Swift

// MARK: - Example using html template
// You can create your html template in Mailgun web site

import SWMailgun

let service = MailgunService()
let parameters = ["user_name": "John", "temporary_password": "johnjohn123"]

guard let variables = try? JSONSerialization.data(withJSONObject: [parameters], options: .prettyPrinted) else {
    print("❌ Something wrong. Check your parameters")
    return
}

let email = MailgunEmail(
    from: "Excited User <hello.world@mail.com>",
    to: "mock@test.com",
    subject: "This is a test",
    template: "forgot_password",
    variables: variables
)

let auth = MailgunAuth(
    domain: "YOUR_DOMAIN",
    apiKey: "YOUR_API_KEY"
)

service.send(email: email, auth: auth) { result, error in
    guard let result = result else {
        print("Error: \(error)")
        return
    }
    print("Email was sent: \(result.isSent())")
}
```

*If you need more examples, open [`demo project`](https://github.com/thejohnlima/SWMailgun/tree/master/Example).*

## 🙋🏻‍♂️ Communication

- If you found a bug, open an issue.
- If you have a feature request, open an issue.
- If you want to contribute, submit a pull request. 👨🏻‍💻

## 📜 License

**SWMailgun** is under MIT license. See the [LICENSE](https://raw.githubusercontent.com/thejohnlima/SWMailgun/master/LICENSE) file for more info.

## ☕️ Support

<a href="https://www.buymeacoffee.com/thejohnlima" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
