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
    var newString = string

    // Insert lines when there's a new paragraph
    newString = newString.replacingOccurrences(of: "</p><p>", with: "\n\n", options: .regularExpression, range: nil)

    // Replace <br> with new line
    newString = newString.replacingOccurrences(of: "<br>", with: "\n", options: .regularExpression, range: nil)

    // Remove HTML tags
    newString = newString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

    return newString
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
