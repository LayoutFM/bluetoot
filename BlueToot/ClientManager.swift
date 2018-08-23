//
//  ClientManager.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/21/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import OAuthSwift
import MastodonKit

class Mastodon {
  static var client: Client {
    return Client(
      baseURL: "https://mastodon.design",
      accessToken: UserDefaults.standard.value(forKey: "oauthToken") as? String
    )
  }
}

class ClientManager {
  private let baseURL: String
  private var oauth: OAuth2Swift!

  public var isAuthorized: Bool {
    return UserDefaults.standard.value(forKey: "oauthToken") as? String != nil
  }

  public var client: Client {
    return Client(
      baseURL: "https://mastodon.design",
      accessToken: UserDefaults.standard.value(forKey: "oauthToken") as? String
    )
  }


  init(baseURL: String) {
    self.baseURL = baseURL
  }

  func authorize(viewController: UIViewController, success: @escaping () -> Void) {
    if isAuthorized {
      success()
      return
    }

    let request = Clients.register(
      clientName: "BlueToot",
      redirectURI: "bluetoot://oauth-callback",
      scopes: [.read, .write, .follow],
      website: "https://kevinclark.ca"
    )

    client.run(request) { (result) in
      guard let application = result.value else { return }

      self.oauth = OAuth2Swift(
        consumerKey: application.clientID,
        consumerSecret: application.clientSecret,
        authorizeUrl: "\(self.baseURL)/oauth/authorize",
        accessTokenUrl: "\(self.baseURL)/oauth/token",
        responseType: "code"
      )

      self.oauth.allowMissingStateCheck = true
      self.oauth.authorizeURLHandler = SafariURLHandler(viewController: viewController, oauthSwift: self.oauth)

      DispatchQueue.main.async {
        self.oauth.authorize(withCallbackURL: URL(string: "bluetoot://oauth-callback")!, scope: "read+write+follow", state: "", success: { (credential, response, parameters) in
          UserDefaults.standard.set(credential.oauthToken, forKey: "oauthToken")
          success()
        }, failure: { (error) in
          print(error)
        })
      }
    }
  }

}
