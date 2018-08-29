//
//  NotificationTableViewCell.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/28/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

  lazy var mainStackView: UIStackView = {
    let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    return stackView
  }()

  lazy var iconImageView: NotificationBadgeView = {
    let badge = NotificationBadgeView()
        badge.statusIcon.image = UIImage(named: "favorited-badge")

    let heightConstraint = badge.heightAnchor.constraint(equalToConstant: 50)
    heightConstraint.priority = UILayoutPriority(999)

    badge.addConstraints([
      heightConstraint,
      badge.widthAnchor.constraint(equalToConstant: 50)
    ])

    return badge
  }()

  lazy var contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 3
    stackView.alignment = .leading
    stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)

    return stackView
  }()

  lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 17
        imageView.layer.masksToBounds = true

    let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 34)
        heightConstraint.priority = UILayoutPriority(999)

    imageView.addConstraints([
      heightConstraint,
      imageView.widthAnchor.constraint(equalToConstant: 34)
    ])

    return imageView
  }()

  lazy var titleLabel: UILabel = {
    let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
    return label
  }()

  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(white: 0, alpha: 0.5)
        label.numberOfLines = 2
    return label
  }()


  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(mainStackView)
    contentView.addConstraints([
      mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
      mainStackView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: 0),
      mainStackView.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor, constant: 0),
      mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
      ])

    mainStackView.addArrangedSubview(iconImageView)
    mainStackView.addArrangedSubview(contentStackView)

    contentStackView.addArrangedSubview(avatarImageView)
    contentStackView.addArrangedSubview(titleLabel)
    contentStackView.addArrangedSubview(descriptionLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
