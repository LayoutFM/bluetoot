//
//  NotificationBadgeView.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/28/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class NotificationBadgeView: UIView {
  let statusIcon = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    statusIcon.translatesAutoresizingMaskIntoConstraints = false
    
    self.addSubview(statusIcon)
    self.addConstraints([
      statusIcon.topAnchor.constraint(equalTo: self.topAnchor),
      statusIcon.rightAnchor.constraint(equalTo: self.rightAnchor),
      statusIcon.widthAnchor.constraint(equalToConstant: 20),
      statusIcon.heightAnchor.constraint(equalToConstant: 20)
    ])
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
