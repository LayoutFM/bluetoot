//
//  Extensions.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/23/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

extension UIImageView {
  func downloadImage(from url: URL) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data else { return }

      let image = UIImage(data: data)

      DispatchQueue.main.async() {
        self.image = image
      }
    }.resume()
  }

  func downloadImage(from string: String) {
    let url = URL(string: string)
    self.downloadImage(from: url!)
  }
}
