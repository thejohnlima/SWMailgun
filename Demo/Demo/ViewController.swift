//
//  ViewController.swift
//  Demo
//
//  Created by John Lima on 27/05/19.
//  Copyright © 2019 limadeveloper. All rights reserved.
//

import UIKit
import BaseNetworkKit

class ViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var textField: UITextField!
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
    guard let text = textField.text, !text.isEmpty else {
      showAlert(message: "Email not found")
      return
    }
    viewModel.sendEmail(to: text)
    view.endEditing(true)
  }

  // MARK: - Private Methods
  private func setupUI() {
    textField.delegate = self
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.darkGray.cgColor

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
          self.showAlert(message: result.message)
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
}

extension ViewController: UITextFieldDelegate {
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    send(sendButton)
    return true
  }
}
