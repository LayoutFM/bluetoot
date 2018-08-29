//
//  ProfileViewController.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/29/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class ProfileViewController: UIViewController {
  
  lazy var mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .top
    stackView.spacing = 12
    stackView.backgroundColor = .red
    return stackView
  }()
  
  lazy var profileView: UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    view.backgroundColor = .blue
    return view
  }()
  
  lazy var profileName: UILabel = {
    let label = UILabel()
    label.text = "John Doe"
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.backgroundColor = .cyan
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Profile"
    tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 0)

    self.view.addSubview(mainStackView)
    self.view.addConstraints([
      mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
      mainStackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 0),
      mainStackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: 0),
      mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
    ])
    
    mainStackView.addArrangedSubview(profileView)
    mainStackView.addArrangedSubview(profileName)
  }

}
