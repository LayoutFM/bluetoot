//
//  TootTextView.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/23/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class TootTextView: UITextView {
  override var text: String! {
    didSet {
      let css = """
        <style>
          * {
            font-family: -apple-system, sans-serif;
            font-size: 17px;
          }

          body {
            margin: 0 !important;
            padding: 0 !important;
          }

          p {
            margin: 0 !important;
            line-height: 1.5 !important;
          }

          p + p {
            margin-top: 1em !important;
          }

          .invisible {
            display: none;
          }

          a { text-decoration: none; }

          .hashtag {
            color: #999 !important;
          }
        </style>
      """

      let finalText = css + text

      guard let data = finalText.data(using: String.Encoding.utf8) else {
        return
      }

      attributedText = try! NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
  }

  override var canBecomeFirstResponder: Bool {
    return false
  }

  init() {
    super.init(frame: .zero, textContainer: nil)

    // Set defaults
    isScrollEnabled = false
    textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: -20, right: 0)
    isEditable = false
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
