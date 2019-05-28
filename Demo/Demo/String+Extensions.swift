//
//  String+Extensions.swift
//  Demo
//
//  Created by John Lima on 27/05/19.
//  Copyright © 2019 limadeveloper. All rights reserved.
//

import Foundation

extension String {
  var htmlToAttributedString: NSAttributedString? {
    guard let data = data(using: .utf8) else { return nil }
    do {
      let result = try NSAttributedString(
        data: data,
        options: [
          .documentType: NSAttributedString.DocumentType.html,
          .characterEncoding: String.Encoding.utf8.rawValue
        ],
        documentAttributes: nil
      )
      return result
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }

  var htmlToString: String {
    return htmlToAttributedString?.string ?? ""
  }
}
