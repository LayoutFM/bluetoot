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
    label.font = UIFont.boldSystemFont(ofSize: 19)
    label.text = "User Name"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var userDomainLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15)
    label.textColor = UIColor(white: 0, alpha: 0.3)
    label.text = "User Domain"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var userBioLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17)
    label.text = "Bio goes here"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 32.5
    imageView.layer.masksToBounds = true
    
    let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 65)
    heightConstraint.priority = UILayoutPriority(999)
    
    imageView.addConstraints([
      heightConstraint,
      imageView.widthAnchor.constraint(equalToConstant: 65)
      ])
  
    return imageView
  }()
  
  lazy var bannerImageView: UIImageView = {
    let imageView = UIImageView(frame: CGRect.zero)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.masksToBounds = true
    imageView.contentMode = .center
    
    let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 180)
    heightConstraint.priority = UILayoutPriority(999)
    
    imageView.addConstraints([heightConstraint])
    
    return imageView
  }()
  
  lazy var followingCount: Int = {
    let number = Int()
    return number
  }()
  
  lazy var followerCount: Int = {
    let number = Int()
    return number
  }()
  
  lazy var followersButton: UIButton = {
    let button = UIButton()
    let label = String(followerCount) + " FOLLOWERS"
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(label, for: .normal)
    button.backgroundColor = .lightGray
    button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    button.layer.cornerRadius = 15
    
    let heightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
    heightConstraint.priority = UILayoutPriority(999)
    
    button.addConstraints([heightConstraint])
    
    return button
  }()
  
  lazy var followingButton: UIButton = {
    let button = UIButton()
    let label = String(followingCount) + " FOLLOWING"
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(label, for: .normal)
    button.backgroundColor = .lightGray
    button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    button.layer.cornerRadius = 15
    
    let heightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
    heightConstraint.priority = UILayoutPriority(999)
    
    button.addConstraints([heightConstraint])
    return button
  }()
  
  lazy var mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .top
    stackView.spacing = 18
    return stackView
  }()
  
  lazy var wrapperStack: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .top
    stackView.spacing = 13
    
    return stackView
  }()
  
  lazy var metadataStack: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 9
    return stackView
  }()
  
  lazy var identityStack: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .top
    stackView.spacing = 1
    return stackView
  }()
  
  lazy var followStack: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 8
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(mainStackView)

    self.addConstraints([
      mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
      mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
      mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
      mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
      ])

    mainStackView.addArrangedSubview(bannerImageView)
    mainStackView.addArrangedSubview(wrapperStack)
    wrapperStack.addArrangedSubview(metadataStack)
    wrapperStack.addArrangedSubview(userBioLabel)
    wrapperStack.addArrangedSubview(followStack)
    metadataStack.addArrangedSubview(avatarImageView)
    metadataStack.addArrangedSubview(identityStack)
    identityStack.addArrangedSubview(userNameLabel)
    identityStack.addArrangedSubview(userDomainLabel)
    followStack.addArrangedSubview(followersButton)
    followStack.addArrangedSubview(followingButton)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
