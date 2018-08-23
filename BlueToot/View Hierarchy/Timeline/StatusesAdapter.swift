//
//  StatusesAdapter.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class StatusDataProvider: ArrayDataProvider {
  var items: [Any] = []

  func loadData(completion: (() -> Void)?) {
    let homeRequest = Timelines.home()

    Mastodon.client.run(homeRequest) { result in
      guard let statuses = result.value else { return }

      DispatchQueue.main.async {
        self.items = statuses
        completion?()
      }
    }
  }
}

class StatusDataPresenter: TableViewDataPresenter {
  func registerCells(for tableView: UITableView) {
    tableView.register(StatusTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
  }

  func cell(for item: Any, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
    guard let status = item as? Status else { fatalError() }

    let formattedContent = status.content.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! StatusTableViewCell
    cell.userNameLabel.text = status.account.displayName
    cell.contentLabel.text = formattedContent

    let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2

    let normalAttributes: [NSAttributedString.Key: Any] = [
      .font: UIFont.systemFont(ofSize: 17),
      .paragraphStyle: paragraphStyle
    ]

    let attributedString = NSMutableAttributedString(string: formattedContent, attributes: normalAttributes)

    let regex = try! NSRegularExpression(pattern: "@\\S*", options: [])

    let range = NSRange(location: 0, length: formattedContent.utf16.count)

    for match in regex.matches(in: formattedContent, options: [], range: range) {
      attributedString.addAttribute(.link, value: "http://google.com", range: match.range)
    }

//    if let substringRange = formattedContent.range(of: "@rafa") {
//      let nsRange = NSRange(substringRange, in: formattedContent)
//      attributedString.addAttribute(.link, value: "http://google.com", range: nsRange)
//    }




    let linkAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: cell.tintColor,
      .font: UIFont.systemFont(ofSize: 27)
    ]



    cell.contentLabel.linkTextAttributes = linkAttributes
    cell.contentLabel.attributedText = attributedString

//
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"This is an example by @marcelofabri_"];
//    [attributedString addAttribute:NSLinkAttributeName
//      value:@"username://marcelofabri_"
//      range:[[attributedString string] rangeOfString:@"@marcelofabri_"]];
//
//
//    NSDictionary *linkAttributes = @{NSForegroundColorAttributeName: [UIColor greenColor],
//      NSUnderlineColorAttributeName: [UIColor lightGrayColor],
//      NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};

//    // assume that textView is a UITextView previously created (either by code or Interface Builder)
//    textView.linkTextAttributes = linkAttributes; // customizes the appearance of links
//    textView.attributedText = attributedString;
//    textView.delegate = self;

    return cell
  }
}
