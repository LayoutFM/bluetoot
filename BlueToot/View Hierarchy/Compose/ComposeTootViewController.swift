//
//  ComposeTootViewController.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/22/18.
//

import UIKit
import MastodonKit

class ComposeTootViewController: UIViewController, UITextViewDelegate {
  let client: Client

  lazy var tootTextView: UITextView = {
    let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.text = "Sent from BlueToot"
        textView.textColor = .lightGray
        textView.font = .systemFont(ofSize: 15)
        textView.isSelectable = true
        textView.dataDetectorTypes = .link
        textView.autocorrectionType = .yes
        textView.autocapitalizationType = .sentences
        textView.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        textView.layer.borderWidth = 1 / UIScreen.main.scale
        textView.layer.cornerRadius = 5
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 4)
    return textView
  }()

  init(client: Client) {
    self.client = client
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

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
    self.navigationItem.rightBarButtonItem = tootButton
  }
    
    @objc func postNewToot() {
        print("🆒 You pressed the Post button")
        let post = Statuses.create(status: tootTextView.text)

        client.run(post) { error in
          print(error)
            // do something with 'status'
        }

    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

}
