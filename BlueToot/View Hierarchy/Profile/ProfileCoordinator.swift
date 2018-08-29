//
//  ProfileCoordinator.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/29/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class ProfileCoordinator: Coordinator {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()
  
  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = ProfileViewController()
    self.navigationController.pushViewController(viewController, animated: false)
  }

}
