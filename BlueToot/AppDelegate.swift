//
//  AppDelegate.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/21/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var rootCoordinator: RootCoordinator?
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()

    let rootCoordinator = RootCoordinator(window: window)
    rootCoordinator.start()

    self.rootCoordinator = rootCoordinator

    return true
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if (url.host == "oauth-callback") {
      OAuthSwift.handle(url: url)
    }
    return true
  }
}

