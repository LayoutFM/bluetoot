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
    let clientManager = ClientManager(baseURL: "https://mastodon.design")

    clientManager.authorize(viewController: tabBarController) {
      let timelineNavigationController = UINavigationController()
      let timelineCoordinator = TimelineCoordinator(with: timelineNavigationController)
          timelineCoordinator.start()

      let localNavigationController = UINavigationController()
      let localCoordinator = LocalCoordinator(with: localNavigationController)
          localCoordinator.start()

      let notificationsNavigationController = UINavigationController()
      let notificationsCoordinator = NotificationsCoordinator(with: notificationsNavigationController)
          notificationsCoordinator.start()

      let profileNavigationController = UINavigationController()
      let profileCoordinator = ProfileCoordinator(with: profileNavigationController)
          profileCoordinator.start()

      let search = UINavigationController()
          search.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), selectedImage: nil)

      self.tabBarController.viewControllers = [
        timelineNavigationController,
        notificationsNavigationController,
        search,
        profileNavigationController
      ]
    }
  }
}
