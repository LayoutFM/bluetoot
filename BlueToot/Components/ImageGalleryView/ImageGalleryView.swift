//
//  ImageGalleryView.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/25/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class ImageGalleryView: UIView {
  var spacing: CGFloat = 3

  lazy var imageViews: [UIImageView] = {
    return [
      firstImageView,
      secondImageView,
      thirdImageView,
      fourthImageView
    ]
  }()

  var images: [String] = [] {
    didSet {
      // Toggle visibility of the views
      self.isHidden = images.count <= 0
      rightStackView.isHidden = images.count <= 1
      imageViews.forEach { $0.isHidden = true }

      for (index, image) in images.enumerated() {
        imageViews[index].isHidden = false
        imageViews[index].downloadImage(from: image)
      }
    }
  }

  lazy var mainStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = spacing
        stackView.distribution = .fillEqually
    return stackView
  }()

  lazy var leftStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [firstImageView, thirdImageView])
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.distribution = .fillEqually
    return stackView
  }()

  lazy var rightStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [secondImageView, fourthImageView])
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.distribution = .fillEqually
    return stackView
  }()

  lazy var firstImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.layer.masksToBounds = true
    return imageView
  }()

  lazy var secondImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.layer.masksToBounds = true
    return imageView
  }()

  lazy var thirdImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.layer.masksToBounds = true
    return imageView
  }()

  lazy var fourthImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.layer.masksToBounds = true
    return imageView
  }()


  init() {
    super.init(frame: .zero)

    self.layer.cornerRadius = 10
    self.layer.masksToBounds = true

    self.addSubview(mainStackView)
    self.addConstraints([
      mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
      mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
