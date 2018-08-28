//
//  NotificationTableViewCell.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/24/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
  
  lazy var notificationType: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 12)
    label.layer.opacity = 0.5
    return label
  }()
    
  lazy var userNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 17)
    return label
  }()
  
  lazy var contentLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()
  
  lazy var profilePicture: UIImageView = {
    let view = UIImageView()
    view.layer.masksToBounds = false
    view.layer.cornerRadius = view.frame.height/2
    view.clipsToBounds = true
    view.backgroundColor = .blue
    return view
  }()
  
  lazy var avatarGroup: UIView = {
    let view = UIView(frame: CGRect(x: 16, y: 16, width: 44, height: 44))
    view.addSubview(profilePicture)
    view.backgroundColor = .red
    return view
  }()
  
  lazy var contentStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [notificationType, userNameLabel, contentLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 5
    return stackView
  }()
  
  lazy var mainStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [avatarGroup, contentStackView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.spacing = 14
    return stackView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(mainStackView)
    contentView.addConstraints([
      mainStackView.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor, constant: 5),
      mainStackView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: contentView.readableContentGuide.bottomAnchor, constant: -5)
    ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}