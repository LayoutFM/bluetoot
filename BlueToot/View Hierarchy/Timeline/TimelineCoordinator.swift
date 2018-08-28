//
//  TimelineCoordinator.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit
import SafariServices

class TimelineCoordinator: NSObject, Coordinator, PresentableCoordinatorDelegate {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()

  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let dataProvider = StatusDataProvider()
    let dataPresenter = StatusDataPresenter()
        dataPresenter.delegate = self
    let viewController = TootsTableViewController(provider: dataProvider, presenter: dataPresenter)
        viewController.delegate = self
    self.navigationController.pushViewController(viewController, animated: false)
  }
}

extension TimelineCoordinator: TootsDelegate {
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
}

extension TimelineCoordinator: UITextViewDelegate {
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    let safariVC = SFSafariViewController(url: URL)
    navigationController.present(safariVC, animated: true, completion: nil)
    return false
  }
}
