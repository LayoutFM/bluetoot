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

class ProfileCoordinator: NSObject, Coordinator, PresentableCoordinatorDelegate, TootsDelegate {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()
  
  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    
    Mastodon.client.run(Accounts.currentUser()) { result in
      guard let currentUser = result.value else { return }
    
      DispatchQueue.main.async {
        let dataProvider = ProfileDataProvider(account: currentUser)
        let dataPresenter = StatusDataPresenter()
            dataPresenter.delegate = self
        let viewController = ProfileTableViewController(provider: dataProvider, presenter: dataPresenter)
        self.navigationController.pushViewController(viewController, animated: false)
      }
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
