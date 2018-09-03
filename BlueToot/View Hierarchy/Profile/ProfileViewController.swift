//
//  ProfileViewController.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/29/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class ProfileTableViewController: TableViewControllerWithDataAdapter {
  var delegate: TootsDelegate?
  
  override init(provider: DataProvider, presenter: TableViewDataPresenter) {
    super.init(provider: provider, presenter: presenter)

    title = "Profile"
    tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let headerView = ProfileHeaderView(frame: CGRect.zero)
    headerView.backgroundColor = .cyan
    
    let containerView = UIView()
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(headerView)
    
    self.tableView.tableHeaderView = containerView
    containerView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
    containerView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
    containerView.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true

    self.tableView.tableHeaderView?.layoutIfNeeded()
  }
  
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    guard let status = self.dataProvider.item(at: indexPath) as? Status else { return nil }
    
    // Reply
    let reply = UIContextualAction(style: .normal, title: "Reply") { (action, view, completionHandler) in
      self.delegate?.reply(to: status)
      completionHandler(true)
    }
    reply.image = UIImage(named: "reply")
    reply.backgroundColor = view.tintColor
    
    // Boost
    let boost = UIContextualAction(style: .normal, title: "Boost") { (action, view, completionHandler) in
      self.delegate?.boost(status: status)
      completionHandler(true)
    }
    boost.image = UIImage(named: "boost")
    boost.backgroundColor = UIColor(red: 25/255, green: 204/255, blue: 71/255, alpha: 1)
    
    return UISwipeActionsConfiguration(actions: [reply, boost])
  }
  
  @objc func didPressToot(button: UIButton) {
    delegate?.didPressToot(button: button)
  }
}
