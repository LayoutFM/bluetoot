//
//  StatusTableViewCell.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {

  lazy var mainStackView: UIStackView = {
    let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 12
    return stackView
  }()

  lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true

    let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 50)
        heightConstraint.priority = UILayoutPriority(999)

        imageView.addConstraints([
          heightConstraint,
          imageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    return imageView
  }()

  lazy var userNameLabel: UILabel = {
    let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
    return label
  }()

  lazy var timeStampLabel: UILabel = {
    let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(white: 0, alpha: 0.3)
    return label
  }()

  lazy var userNameStackView: UIStackView = {
    let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
    return stackView
  }()

  var contentTextView = TootTextView()

  lazy var textStackView: UIStackView = {
    let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
    return stackView
  }()

  lazy var imageGalleryView: ImageGalleryView = {
    let imageGalleryView = ImageGalleryView()
        imageGalleryView.translatesAutoresizingMaskIntoConstraints = false
    let heightConstraint = imageGalleryView.heightAnchor.constraint(equalToConstant: 200)
    heightConstraint.priority = UILayoutPriority(999)

        imageGalleryView.addConstraints([
          heightConstraint
        ])
    return imageGalleryView
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

    mainStackView.addArrangedSubview(avatarImageView)
    mainStackView.addArrangedSubview(textStackView)

    textStackView.addArrangedSubview(userNameStackView)
    textStackView.addArrangedSubview(contentTextView)
    textStackView.addArrangedSubview(imageGalleryView)
    textStackView.setCustomSpacing(15, after: contentTextView)

    userNameStackView.addArrangedSubview(userNameLabel)
    userNameStackView.addArrangedSubview(timeStampLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
