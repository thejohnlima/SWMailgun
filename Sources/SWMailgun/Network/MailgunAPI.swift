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

public enum MailgunAPI {
  case sendEmail(auth: MailgunAuth, email: MailgunEmail, environment: NKEnvironment)
}

extension MailgunAPI: NKFlowTarget {
  public var baseURL: URL {
    switch self {
    case .sendEmail(let auth, _, _):
      return URL(stringValue: "https://api:\(auth.apiKey)@api.mailgun.net/v3/\(auth.domain)/")
    }
  }

  public var path: String {
    return "messages"
  }

  public var method: NKHTTPMethods {
    return .post
  }

  public var task: NKTask {
    switch self {
    case .sendEmail(_, let email, _):
      let parameters = email.toJSON
      return .requestCompositeParameters(bodyParameters: [:], urlParameters: parameters)
    }
  }

  public var environment: NKEnvironment {
    switch self {
    case .sendEmail(_, _, let environment):
      return environment
    }
  }
}
