//
//  ViewController.swift
//  BJTextView
//
//  Created by Sovannra on 12/17/2021.
//  Copyright (c) 2021 Sovannra. All rights reserved.
//

import UIKit
import BJTextView

class ViewController: UIViewController {

    var bottomConstraint: NSLayoutConstraint?
    
    lazy var vComment: BJCommentTextView = {
        let view = BJCommentTextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view.endEditing(true)
        vComment.dismissKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        vComment.dismissKeyboard()
    }
    
    deinit {
        deregisterFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupComponent()
        vComment.popupKeyboard()
        
//        let vImage: UIImageView = UIImageView()
//        let imageUrl = "https://i.pinimg.com/originals/82/ba/cc/82baccf7daa8ba41036459e86732ef3e.jpg"
//        let comment = BJCommentModel(commentId: "1", text: "Hello")
//        vComment.updateComment(comment)
//        if imageUrl != "" {
//            vImage.loadImage(with: imageUrl, completion: { [self] response,error in
//                let comment = BJCommentModel(commentId: "1", image: vImage.image, text: "Hello")
//                vComment.updateComment(comment)
//            })
//        }
    }
    
    
    @objc func handleTap() {
        view.endEditing(true)
        vComment.resetSticker()
    }
    
    func setupComponent() {
        view.addSubview(vComment)
        vComment.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        vComment.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomConstraint = vComment.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomConstraint?.isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleKeyBoardNotification(notification: Notification) {
        if notification.name == UIResponder.keyboardWillShowNotification {
            vComment.resetSticker()
        }
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            bottomConstraint?.constant = isKeyboardShowing ? -(keyboardSize.height - view.safeAreaInsets.bottom): 0
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut) {
                self.view.layoutIfNeeded()
            } completion: { completed in }
        }
    }

    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension ViewController: BJCommentDelegate {
    func didSelectSticker(_ isSelected: Bool) {
        if isSelected == true && vComment.stickerData == nil {
            LocalDataSticker.loadSticker()
            vComment.stickerData = LocalDataSticker.stickerData
        }
    }
    
    func sendComment(_ comment: BJCommentModel) {
        print("Comment => \(comment)")
    }
}
