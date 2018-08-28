//
//  NotificationTableViewCell.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/24/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class NotificationTableViewCell: StatusTableViewCell {
  
  lazy var notificationType: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 12)
    label.layer.opacity = 0.5
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(mainStackView)
    contentView.addConstraints([
      mainStackView.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor, constant: 5),
      mainStackView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: -2),
      mainStackView.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor, constant: 2),
      mainStackView.bottomAnchor.constraint(equalTo: contentView.readableContentGuide.bottomAnchor, constant: -5)
      ])
  }

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
