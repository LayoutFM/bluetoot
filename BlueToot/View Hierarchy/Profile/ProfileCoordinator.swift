//
//  ProfileCoordinator.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/29/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit
import SafariServices

class ProfileCoordinator: NSObject, Coordinator, PresentableCoordinatorDelegate {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()
  
  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let dataProvider = ProfileDataProvider()
    let dataPresenter = StatusDataPresenter()
        dataPresenter.delegate = self
    let viewController = ProfileTableViewController(provider: dataProvider, presenter: dataPresenter)
        viewController.delegate = self
    self.navigationController.pushViewController(viewController, animated: false)
  }
}

extension ProfileCoordinator: TootsDelegate {
  func didPressToot(button: UIButton) {
    let composeNavigationController = UINavigationController()
    let composeCoordinator = ComposeCoordinator(with: composeNavigationController)
    composeCoordinator.delegate = self
    composeCoordinator.start()
    
    childCoordinators.append(composeCoordinator)
    
    navigationController.present(composeNavigationController, animated: true, completion: nil)
  }
  
  func reply(to status: Status) {
    let composeNavigationController = UINavigationController()
    let composeCoordinator = ComposeCoordinator(with: composeNavigationController)
    composeCoordinator.replyToStatus = status
    composeCoordinator.delegate = self
    composeCoordinator.start()
    
    childCoordinators.append(composeCoordinator)
    
    navigationController.present(composeNavigationController, animated: true, completion: nil)
  }
  
  func boost(status: Status) {
    let boost = Statuses.reblog(id: status.id)
    
    Mastodon.client.run(boost) { result in
      print("You boosted this toot!")
    }
  }
}

extension ProfileCoordinator: UITextViewDelegate {
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    let safariVC = SFSafariViewController(url: URL)
    navigationController.present(safariVC, animated: true, completion: nil)
    return false
  }
}
