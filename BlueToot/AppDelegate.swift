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

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//    let rootNavigationController = UINavigationController()
//    let coordinator = RootCoordinator(with: rootNavigationController)
//        coordinator.start()
//    // This is what you had, Kevin 👆
    
    let tabBarController = UITabBarController()
    var homeVC = UITableViewController()
    
    // Auth and create instance of timeline
    let clientManager = ClientManager(baseURL: "https://mastodon.design")
    clientManager.authorize(viewController: tabBarController) {
        let dataProvider = StatusDataProvider(client: clientManager.client)
        let dataPresenter = StatusDataPresenter()
        homeVC = TootsTableViewController(provider: dataProvider, presenter: dataPresenter)
    }
    
    // Continue creation of all 3 main views in the Tab Bar
    homeVC.title = "Home"
    homeVC.tabBarItem = UITabBarItem(title: "🏠 Home", image: nil, tag: 0)
    
    let localVC = UIViewController()
    localVC.title = "Local"
    localVC.tabBarItem = UITabBarItem(title: "👩‍👧‍👦 Local", image: nil, tag: 0)
    
    let notificationsVC = UIViewController()
    notificationsVC.title = "Notifications"
    notificationsVC.tabBarItem = UITabBarItem(title: "🛎 Notifications", image: nil, tag: 0)
    
    // Temp: Just for visual debug
    homeVC.view.backgroundColor = UIColor.white
    localVC.view.backgroundColor = UIColor.red
    notificationsVC.view.backgroundColor = UIColor.cyan
    
    
    // Add a UINavigationController to each VC in the Tab
    let controllers = [homeVC, localVC, notificationsVC]
    tabBarController.viewControllers = controllers.map {
        UINavigationController(rootViewController: $0)
    }
    
    // Make the TabBar the root controller 🎉
    let rootNavigationController = tabBarController

    window?.rootViewController = rootNavigationController
    window?.backgroundColor = .white
    window?.makeKeyAndVisible()

    return true
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if (url.host == "oauth-callback") {
      print(url)
      OAuthSwift.handle(url: url)
    }
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

