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
    
    let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 50)
    heightConstraint.priority = UILayoutPriority(999)
    
    imageView.addConstraints([
      heightConstraint,
      imageView.widthAnchor.constraint(equalToConstant: 50)
      ])
    return imageView
  }()
  
  lazy var bannerImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.masksToBounds = true
    
    let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 300)
    heightConstraint.priority = UILayoutPriority(999)
    
    imageView.addConstraints([
      heightConstraint,
      imageView.widthAnchor.constraint(equalToConstant: 300)
      ])
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

  var shouldSetupConstraints = true
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    print("⚡️ View did load, in fact")
    self.addSubview(mainStackView)
    self.addConstraints([
      mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
      mainStackView.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor, constant: 0),
      mainStackView.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor, constant: 0),
      mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
      ])
    mainStackView.addArrangedSubview(bannerImageView)
    mainStackView.addArrangedSubview(avatarImageView)
    mainStackView.addArrangedSubview(userNameLabel)
    mainStackView.addArrangedSubview(userDomainLabel)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func updateConstraints() {
    if(shouldSetupConstraints) {
      // AutoLayout constraints
      shouldSetupConstraints = false
    }
    super.updateConstraints()
  }
}
