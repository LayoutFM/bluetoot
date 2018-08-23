//
//  ComposeTootViewController.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/22/18.
//

import UIKit
import MastodonKit

protocol ComposeTootDelegate {
  func didPressCancel(button: UIBarButtonItem)
  func post(status: String)
}

class ComposeTootViewController: UIViewController, UITextViewDelegate {
  var delegate: ComposeTootDelegate?

  lazy var tootTextView: UITextView = {
    let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.font = .systemFont(ofSize: 17)
        textView.dataDetectorTypes = .link
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        textView.becomeFirstResponder()
    return textView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Compose"

    view.backgroundColor = .white // Otherwise the transition glitches

    view.addSubview(tootTextView)
    view.addConstraints([
      tootTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
      tootTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
      tootTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
      tootTextView.heightAnchor.constraint(equalToConstant: 200)
    ])

    // Set up the Toot/Submit button in the Navigation Bar
    let tootButton = UIBarButtonItem(title: "Toot", style: .done, target: self, action: #selector(postNewToot))
    navigationItem.rightBarButtonItem = tootButton

    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didPressCancel(button:)))
    navigationItem.leftBarButtonItem = cancelButton
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.view.endEditing(true)
  }

  @objc func didPressCancel(button: UIBarButtonItem) {
    delegate?.didPressCancel(button: button)
  }
    
  @objc func postNewToot() {
    delegate?.post(status: tootTextView.text)
  }

}
