# BJTextView

[![CI Status](https://img.shields.io/travis/Sovannra/BJTextView.svg?style=flat)](https://travis-ci.org/Sovannra/BJTextView)
[![Version](https://img.shields.io/cocoapods/v/BJTextView.svg?style=flat)](https://cocoapods.org/pods/BJTextView)
[![License](https://img.shields.io/cocoapods/l/BJTextView.svg?style=flat)](https://cocoapods.org/pods/BJTextView)
[![Platform](https://img.shields.io/cocoapods/p/BJTextView.svg?style=flat)](https://cocoapods.org/pods/BJTextView)

<img width="30%" height="30%" src="https://user-images.githubusercontent.com/49421174/147409620-c1ce6f3d-4482-4399-857e-fec2f2109f94.jpeg" /><img width="30%" height="30%" src="https://user-images.githubusercontent.com/49421174/147409617-39c335c2-50f8-41e6-955b-cea093bb5472.jpeg" /><img width="30%" height="30%" src="https://user-images.githubusercontent.com/49421174/147409615-18c81475-1d38-4a4e-8ef9-a4cccf3a0ea4.jpeg" />
---
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Features
* Comment with sticker and photo
* Display photo and sticker before sending

## Requirements
* iOS 9.0+
* Swift 4 & 5
* BJCollection
* Nuke
* DKImagePickerController

## Installation
### CocoaPods
#### iOS 9 and newer

BJTextView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BJTextView'
```
## Getting Started
#### Initialization and presentation
```swift

class ViewController: UIViewController {

    /// Declare bottom NSLayoutConstraint to popup & dimiss textView with animation
    var bottomConstraint: NSLayoutConstraint?
    
    /// To declare comment textView
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
    
    /// Popup keyboard when view appear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view.endEditing(true)
        vComment.dismissKeyboard()
    }
    
    /// Dimiss keyboard when view disappear
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
    }
    
    /// Handle click outsize to dismiss keyboard
    @objc func handleTap() {
        view.endEditing(true)
        vComment.resetSticker()
    }
    
    /// Setup component
    func setupComponent() {
        view.addSubview(vComment)
        vComment.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        vComment.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomConstraint = vComment.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomConstraint?.isActive = true
    }
    
    /// Handle keyboard notification to popup commentTextView
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
    
    /// Register keyboard notification
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    /// Unregister from keyboard notification
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

/// Use to handle event delegate
extension ViewController: BJCommentDelegate {
    /// handle click on sticker
    func didSelectSticker(_ isSelected: Bool) {
        if isSelected == true && vComment.stickerData == nil {
            /// Call sticker sevice
        }
    }
    
    /// handle click on send
    func sendComment(_ comment: BJCommentModel) {
        print("Comment => \(comment)")
    }
}

​```
## Author
Sovannra, sovannrakong@gmail.com

## License
BJTextView is available under the MIT license. See the LICENSE file for more info.
