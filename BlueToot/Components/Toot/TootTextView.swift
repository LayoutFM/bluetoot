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
      let paragraphStyle = NSMutableParagraphStyle()
          paragraphStyle.lineHeightMultiple = 1.2

      let tootFormatter = TootFormatter()
          tootFormatter.attributes = [
            .font: UIFont.systemFont(ofSize: 17),
            .paragraphStyle: paragraphStyle
          ]

      attributedText = tootFormatter.mutableAttributedString(from: text)
    }
  }

  override var canBecomeFirstResponder: Bool {
    return false
  }

  init() {
    super.init(frame: .zero, textContainer: nil)

    // Set defaults
    isScrollEnabled = false
    textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
    isEditable = false
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
