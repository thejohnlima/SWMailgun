//  MIT License
//
//  Copyright (c) 2019 John Lima
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import BaseNetworkKit
import Foundation

public struct MailgunEmail: NKCodable {
  public let from: String
  public let to: String
  public let subject: String
  public let html: String?
  public let text: String?
  public let template: String?
  public let variables: Data?

  public init(from: String,
              to: String,
              subject: String,
              html: String? = nil,
              text: String? = nil,
              template: String? = nil,
              variables: Data? = nil) {
    self.from = from
    self.to = to
    self.subject = subject
    self.html = html
    self.text = text
    self.template = template
    self.variables = variables
  }

  public enum CodingKeys: String, CodingKey {
    case from, to, subject, html, text, template
    case variables = "h:X-Mailgun-Variables"
  }

  public var toJSON: NKCommon.JSON {
    typealias K = CodingKeys

    var result = NKCommon.JSON()
    result[K.from.rawValue] = from
    result[K.to.rawValue] = to
    result[K.subject.rawValue] = subject

    if let html = html {
      result[K.html.rawValue] = html
    }

    if let text = text {
      result[K.text.rawValue] = text
    }

    if let template = template {
      result[K.template.rawValue] = template
    }

    if let variables = variables,
      let json = try? JSONSerialization.jsonObject(with: variables, options: .allowFragments) as? NKCommon.JSON {
      result[K.variables.rawValue] = json
    }

    return result
  }
}

extension MailgunEmail: Equatable {
  public static func == (lhs: MailgunEmail, rhs: MailgunEmail) -> Bool {
    return lhs.from == rhs.from &&
      lhs.to == rhs.to &&
      lhs.subject == rhs.subject &&
      lhs.html == rhs.html &&
      lhs.text == rhs.text &&
      lhs.template == rhs.template &&
      lhs.variables == rhs.variables
  }
}
