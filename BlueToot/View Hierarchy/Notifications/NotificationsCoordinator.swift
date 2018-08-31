//
//  NotificationsCoordinator.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit
import SafariServices

class NotificationsCoordinator: NSObject, TootsDelegate {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()

  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let statusPresenter = StatusDataPresenter()
        statusPresenter.delegate = self
    let presenter = NotificationsDataPresenter(statusesPresenter: statusPresenter)
    let viewController = NotificationsTableViewController(provider: NotificationsDataProvider(), presenter: presenter)
        viewController.delegate = self
    navigationController.pushViewController(viewController, animated: false)
  }
}

extension NotificationsCoordinator: UITextViewDelegate {
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    let safariVC = SFSafariViewController(url: URL)
    navigationController.present(safariVC, animated: true, completion: nil)
    return false
  }
}
