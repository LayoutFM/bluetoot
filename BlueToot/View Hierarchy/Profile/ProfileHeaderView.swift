//
//  ProfileHeaderView.swift
//  BlueToot
//
//  Created by Rafael Conde on 9/3/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
  
  lazy var userNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.text = "User Name"
    return label
  }()
  
  lazy var userDomainLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15)
    label.textColor = UIColor(white: 0, alpha: 0.3)
    label.text = "User Domain"
    return label
  }()
  
  lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 25
    imageView.layer.masksToBounds = true
  
    return imageView
  }()
  
  lazy var bannerImageView: UIImageView = {
    let imageView = UIImageView(frame: CGRect.zero)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.masksToBounds = true
  
    imageView.backgroundColor = UIColor.gray
    
    return imageView
  }()
  
  lazy var mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .top
    stackView.spacing = 12
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(mainStackView)

    print("⚡️ View did load, in fact")

    self.addConstraints([
      self.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
      self.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor, constant: 0),
      self.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor, constant: 0),
      self.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
      ])

    mainStackView.addArrangedSubview(avatarImageView)
    mainStackView.addArrangedSubview(bannerImageView)
    mainStackView.addArrangedSubview(userDomainLabel)
    mainStackView.addArrangedSubview(userNameLabel)

  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
