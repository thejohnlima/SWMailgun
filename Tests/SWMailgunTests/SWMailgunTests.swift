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

import XCTest
@testable import SWMailgun

final class SWMailgunTests: XCTestCase {

  // MARK: - Properties
  private var service: MockService?

  static var allTests = [
    ("testSendEmailSuccess", testSendEmailSuccess),
    ("testSendEmailFail", testSendEmailFail)
  ]

  // MARK: - Overrides
  override func setUp() {
    super.setUp()
    service = MockService()
  }

  override func tearDown() {
    service = nil
    super.tearDown()
  }

  // MARK: - Test Methods
  func testSendEmailSuccess() {
    let expectation = self.expectation(description: "Wait for send email with success")

    service?.status = .success

    let email = MailgunEmail(from: "john@johnjohn.com", to: "to@email.com", subject: "Hey human")
    let auth = MailgunAuth(domain: "ABCDE", apiKey: "EDCBA")

    service?.send(email: email, auth: auth) { result, error in
      XCTAssertNil(error)
      XCTAssertEqual(result?.id, "123456")
      XCTAssertEqual(result?.message, "email sent")
      expectation.fulfill()
    }

    waitForExpectations(timeout: 0.3)
  }

  func testSendEmailFail() {
    let expectation = self.expectation(description: "Wait for send email with fail")

    service?.status = .fail

    let email = MailgunEmail(from: "john@johnjohn.com", to: "to@email.com", subject: "Hey human")
    let auth = MailgunAuth(domain: "ABCDE", apiKey: "EDCBA")

    service?.send(email: email, auth: auth) { result, error in
      XCTAssertNil(result)
      XCTAssertEqual((error as? MockService.SWError)?.description, "Something wrong")
      expectation.fulfill()
    }

    waitForExpectations(timeout: 0.3)
  }
}
