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
  var delegate: PresentableCoordinatorDelegate?

  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    guard let client = client else { return }
    let viewController = ComposeTootViewController(client: client)
        viewController.delegate = self
    navigationController.pushViewController(viewController, animated: false)
  }
}

extension ComposeCoordinator: ComposeTootDelegate {
  func didPressCancel(button: UIBarButtonItem) {
    delegate?.didFinishPresenting(coordinator: self)
  }

  func post(status: String) {
    guard let client = client else { return }

    let post = Statuses.create(status: status)

    client.run(post) { result in
      DispatchQueue.main.async {
        if let error = result.error {
          let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
          self.navigationController.present(alert, animated: true, completion: nil)
        } else {
          self.delegate?.didFinishPresenting(coordinator: self)
        }
      }
    }
  }
}
