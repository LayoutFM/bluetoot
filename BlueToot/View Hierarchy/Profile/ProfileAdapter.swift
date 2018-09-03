//
//  ProfileAdapter.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/31/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class ProfileDataProvider: ArrayDataProvider {
  var items: [Any] = []
  let account: Account
  
  init(account: Account) {
    self.account = account
  }
  
  func loadData(completion: (() -> Void)?) {
    
    Mastodon.client.run(Accounts.statuses(id: account.id)) { result in
      guard let statuses = result.value else { return }
      
      DispatchQueue.main.async {
        self.items = statuses
      }
    }
  }
}
