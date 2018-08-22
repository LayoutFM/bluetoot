//
//  RootCoordinator.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class RootCoordinator {
  var window: UIWindow?
  let tabBarController = UITabBarController()

  init(window: UIWindow?) {
    self.window = window

    window?.rootViewController = tabBarController
    window?.backgroundColor = .white
    window?.makeKeyAndVisible()
  }

  func start() {
    let homeNavigationController = UINavigationController()
    let homeCoordinator = TimelineCoordinator(with: homeNavigationController)
        homeCoordinator.start()

    let localNavigationController = UINavigationController()
    let localCoordinator = LocalCoordinator(with: localNavigationController)
        localCoordinator.start()

    let notificationsNavigationController = UINavigationController()
    let notificationsCoordinator = NotificationsCoordinator(with: notificationsNavigationController)
        notificationsCoordinator.start()

    tabBarController.viewControllers = [
      homeNavigationController,
      localNavigationController,
      notificationsNavigationController
    ]
  }
}
