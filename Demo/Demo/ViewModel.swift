//
//  ViewModel.swift
//  Demo
//
//  Created by John Lima on 27/05/19.
//  Copyright © 2019 limadeveloper. All rights reserved.
//

import Foundation
import ObservableKit

class ViewModel {

  // MARK: - Properties
  let service = MailgunService()
  let observable: OKObservable<OKState<MailgunResult>> = OKObservable(.loading)

  var auth: MailgunAuth {
    let domain = "sandbox3f7e1418b6f74ec0bc0a709f1850bd58.mailgun.org"
    let apiKey = "e053edd3640f8a685e1c4770673efdda-39bc661a-4b342f20"
    return MailgunAuth(domain: domain, apiKey: apiKey)
  }

  // MARK: - Public Methods
  func sendEmail(to: String) {
    observable.value = .loading
    service.send(email: compose(email: to), auth: auth, environment: .develop) { result, error in
      guard let result = result else {
        self.observable.value = .errored(error: error!)
        return
      }
      self.observable.value = .load(data: result)
    }
  }

  private func compose(email: String) -> MailgunEmail {
    let html = "<b>Test</b>"
    return MailgunEmail(
      from: "johncarloslima@hotmail.com",
      to: email,
      subject: "This is a test",
      html: html,
      text: html.htmlToString
    )
  }
}
