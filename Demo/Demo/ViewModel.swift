//
//  ViewModel.swift
//  Demo
//
//  Created by John Lima on 27/05/19.
//  Copyright © 2019 limadeveloper. All rights reserved.
//

import Foundation
import ObservableKit
import SWMailgun

class ViewModel {

  // MARK: - Properties
  let service = MailgunService()
  let observable: OKObservable<OKState<MailgunResult>> = OKObservable(.loading)

  // MARK: - Public Methods
  func sendEmail(to: String, auth: MailgunAuth) {
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
      from: "Excited User <hello.world@mail.com>",
      to: email,
      subject: "This is a test",
      html: html
    )
  }
}
