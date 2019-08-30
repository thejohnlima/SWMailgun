//
//  ViewController.swift
//  Example
//
//  Created by John Lima on 27/05/19.
//  Copyright © 2019 limadeveloper. All rights reserved.
//

import BaseNetworkKit
import SWMailgun
import UIKit

class ViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var domainField: UITextField!
  @IBOutlet weak var apiKeyField: UITextField!
  @IBOutlet weak var sendButton: UIButton!

  let viewModel = ViewModel()

  // MARK: - View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    addSendEmailObservable()
    setupUI()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }

  // MARK: - Actions
  @IBAction private func send(_ sender: Any?) {
    guard isFieldsFilled(), let to = emailField.text, let apiKey = apiKeyField.text, let domain = domainField.text else {
      showAlert(message: "Fill all fields")
      return
    }
    viewModel.sendEmail(to: to, auth: MailgunAuth(domain: domain, apiKey: apiKey))
    view.endEditing(true)
  }

  // MARK: - Private Methods
  private func setupUI() {
    for field in [emailField, domainField, apiKeyField] {
      field?.layer.borderWidth = 1
      field?.layer.borderColor = UIColor.darkGray.cgColor
    }

    sendButton.layer.cornerRadius = sendButton.bounds.height / 2
    sendButton.layer.masksToBounds = true
  }

  private func addSendEmailObservable() {
    viewModel.observable.didChange = { state in
      DispatchQueue.main.async {
        switch state {
        case .loading:
          UIApplication.shared.isNetworkActivityIndicatorVisible = true
        case .load(data: let result):
          UIApplication.shared.isNetworkActivityIndicatorVisible = false
          let message = result.isSent() ? "✅ \(result.message)" : "❌ \(result.message)"
          self.showAlert(message: message)
        case .errored(error: let error):
          UIApplication.shared.isNetworkActivityIndicatorVisible = false
          let error = (error as? NKError)?.message ?? error.localizedDescription
          self.showAlert(message: error)
        default:
          UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
      }
    }
  }

  private func showAlert(message: String) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .cancel)
    alert.addAction(action)
    present(alert, animated: true)
  }

  private func isFieldsFilled() -> Bool {
    let result = [emailField, domainField, apiKeyField].first { $0?.text?.isEmpty == true } == nil
    return result
  }
}
