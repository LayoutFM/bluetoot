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

  override public var selectedTextRange: UITextRange? {
    get { return nil }
    set { }
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

  // Only register touches for links
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let glyphIndex = self.layoutManager.glyphIndex(for: point, in: self.textContainer)

    //Ensure the glyphIndex actually matches the point and isn't just the closest glyph to the point
    let glyphRect = self.layoutManager.boundingRect(forGlyphRange: NSRange(location: glyphIndex, length: 1), in: self.textContainer)

    if glyphIndex < self.textStorage.length,
      glyphRect.contains(point),
      self.textStorage.attribute(NSAttributedString.Key.link, at: glyphIndex, effectiveRange: nil) != nil {

      return self
    } else {
      return nil
    }
  }
}
