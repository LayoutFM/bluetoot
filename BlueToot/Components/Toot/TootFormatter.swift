//
//  TootFormatter.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/23/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import Foundation

class TootFormatter {
  var attributes: [NSAttributedString.Key: Any]?

  func mutableAttributedString(from string: String) -> NSMutableAttributedString {
    let newString = stripHTML(from: string)
    let attributedString = NSMutableAttributedString(string: newString, attributes: attributes)

    self.addLinkAttribute(pattern: "@\\S*", to: attributedString)
    self.addLinkAttribute(pattern: "https?://\\S*", to: attributedString)

    return attributedString
  }

  func stripHTML(from string: String) -> String {
    return string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
  }

  func addLinkAttribute(pattern: String, to attributedString: NSMutableAttributedString) {
    let regex = try! NSRegularExpression(pattern: pattern, options: [])

    let range = NSRange(location: 0, length: attributedString.string.utf16.count)

    for match in regex.matches(in: attributedString.string, options: [], range: range) {
      let urlString = attributedString.string[Range(match.range, in: attributedString.string)!]
      attributedString.addAttribute(.link, value: urlString, range: match.range)
    }
  }
}
