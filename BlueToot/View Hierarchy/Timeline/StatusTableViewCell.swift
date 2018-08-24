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
    let stackView = UIStackView(arrangedSubviews: [avatarImageView, textStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 12
    return stackView
  }()

  lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
    imageView.addConstraints([
      imageView.heightAnchor.constraint(equalToConstant: 50),
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
        label.text = "5m"
        label.textColor = UIColor(white: 0, alpha: 0.3)
    return label
  }()

  lazy var userNameStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [userNameLabel, timeStampLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
    return stackView
  }()

  var contentTextView = TootTextView()

  lazy var textStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [userNameStackView, contentTextView, attachmentImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.setCustomSpacing(15, after: contentTextView)
    return stackView
  }()

  lazy var attachmentImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
    imageView.addConstraints([
      imageView.heightAnchor.constraint(equalToConstant: 200)
    ])
    return imageView
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
