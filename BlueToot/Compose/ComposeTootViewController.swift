//
//  ComposeTootViewController.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/22/18.
//

import UIKit
import MastodonKit

class ComposeTootViewController: UIViewController, UITextViewDelegate {
//    let client: Client
    var composedToot = String()
    
//    init(client: Client) {
//        self.client = client
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white // Otherwise the transition glitches

        print("🆒 Loaded the Compose Toot View")
        
        // Create text field
        let textFieldWidth = Double((self.view.frame.width) - 40)
        let tootTextField = UITextView(frame: CGRect(x: 20, y: 100, width: textFieldWidth, height: 200))
        
        tootTextField.delegate = self
        tootTextField.text = "Sent from BlueToot."
        tootTextField.textColor = UIColor.lightGray
        tootTextField.font = UIFont.systemFont(ofSize: 15)
        tootTextField.isSelectable = true
        tootTextField.dataDetectorTypes = UIDataDetectorTypes.link
        tootTextField.autocorrectionType = UITextAutocorrectionType.yes
        tootTextField.autocapitalizationType = UITextAutocapitalizationType.sentences
        tootTextField.layer.borderColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.00).cgColor
        tootTextField.layer.borderWidth = 2.0
        tootTextField.layer.cornerRadius = 5
        tootTextField.textContainerInset = UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 4)
        self.view.addSubview(tootTextField)
        
        // Set up the Toot/Submit button in the Navigation Bar
        let tootButton = UIBarButtonItem(title: "Toot", style: .done, target: self, action: #selector(postNewToot))
        self.navigationItem.rightBarButtonItem = tootButton
    }
    
    @objc func postNewToot() {
        print("🆒 You pressed the Post button")
//        let post = Statuses.create(status: self.composedToot)
//
//        client.run(post) { error in
//            // do something with 'status'
//        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
