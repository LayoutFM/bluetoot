//
//  Coordinator.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

protocol Coordinator {
  var navigationController: UINavigationController { get }
  var childCoordinators: [Coordinator] { get set }

  func start()
}

protocol PresentableCoordinatorDelegate {
  func didFinishPresenting(coordinator: Coordinator)
}
