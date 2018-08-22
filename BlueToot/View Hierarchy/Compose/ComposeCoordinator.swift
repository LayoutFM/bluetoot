//
//  ComposeCoordinator.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class ComposeCoordinator: Coordinator {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()
  var client: Client?

  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    guard let client = client else { return }
    let viewController = ComposeTootViewController(client: client)
    navigationController.pushViewController(viewController, animated: false)
  }
}
