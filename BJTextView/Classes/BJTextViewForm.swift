//
//  BJTextViewForm.swift
//  BJTextView
//
//  Created by Sovannra on 17/12/21.
//

import UIKit

enum IconTextViewType: Int {
    case photo   = 001
    case sticker = 002
    case send    = 003
    case update  = 004
    case cancel  = 005
}

public protocol BJTextViewDelegate {
    func handleIconClick(_ button: UIButton)
}

public class BJTextViewForm: UIView {
    
    public let limitSize: CGFloat = 110
    public let iconSize: CGFloat = 25
    public let textEdgeInset: CGFloat = 10
    public let fontSize: UIFont = .systemFont(ofSize: 14)
    public let placeHolder: NSString = "Write your comment here..."
    public let placeHolderColor: UIColor = .lightGray
    public let textColor: UIColor = .black
    public let selectedStickerColor: UIColor = .systemOrange
    public let unSelectedStickerColor: UIColor = .black
    public var iconPhoto: String = "" {
        didSet {
            vPhoto.setImage(UIImage(named: iconPhoto), for: .normal)
        }
    }
    public var iconSticker: String = "" {
        didSet {
            vSticker.setImage(UIImage(named: iconSticker), for: .normal)
        }
    }
    public var iconSend: String = "" {
        didSet {
            vSend.setImage(UIImage(named: iconSend), for: .normal)
        }
    }
    
    var enableSend: Bool? {
        didSet {
            vSend.isEnabled = enableSend ?? false
            vUpdate.isEnabled = enableSend ?? false
            vUpdate.setTitleColor( enableSend == true ? .black : .gray, for: .normal)
        }
    }
    
    var delegate: BJTextViewDelegate?
    
    /** get & set text value */
    public var textStr: String {
        get {
            return vTextView.text
        } set {
            enableSend = newValue != ""
            vTextView.text = newValue
        }
    }
    
    public var isSelected: Bool? {
        didSet {
            vSticker.isSelected = !(isSelected ?? false)
        }
    }
    
    // Bottom constraint
    fileprivate var isMakeCorner: Bool = false
    fileprivate var vPhotoBottomConstraint: NSLayoutConstraint?
    fileprivate var vSendBottomConstraint: NSLayoutConstraint?
    fileprivate var vStickerBottomConstraint: NSLayoutConstraint?
    fileprivate var vStackViewLeftConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupComponent() {
        
        addSubview(vPhoto)
        addSubview(vTextView)
        addSubview(vSticker)
        addSubview(vStackView)
        vStackView.addArrangedSubview(vCancel)
        vStackView.addArrangedSubview(vUpdate)
        vStackView.addArrangedSubview(vSend)
        
        // vPhoto
        vPhoto.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        vPhoto.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        vPhoto.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        vPhotoBottomConstraint = vPhoto.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        vPhotoBottomConstraint?.isActive = true
        
        // vTextView
        vTextView.textContainerInset = UIEdgeInsets(
            top: textEdgeInset,
            left: textEdgeInset,
            bottom: textEdgeInset,
            right: iconSize + textEdgeInset
        )
        vTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        vTextView.leftAnchor.constraint(equalTo: vPhoto.rightAnchor, constant: 10).isActive = true
        vTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        vTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        // vSticker
        vSticker.rightAnchor.constraint(equalTo: vTextView.rightAnchor, constant: -10).isActive = true
        vSticker.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        vSticker.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        vStickerBottomConstraint = vSticker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        vStickerBottomConstraint?.isActive = true
        
        // vSend
        vStackViewLeftConstraint = vStackView.leftAnchor.constraint(equalTo: vTextView.rightAnchor, constant: 10)
        vStackViewLeftConstraint?.isActive = true
        vStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        vSendBottomConstraint = vStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        vSendBottomConstraint?.isActive = true
        
        //vSend
        vSend.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        vSend.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        //vCancel
        vCancel.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        vCancel.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        //vUpdate
        vUpdate.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    fileprivate lazy var vTextView: BJUITextView = {
        let view = BJUITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = true
        view.isScrollEnabled = false
        view.placeholder = placeHolder
        view.placeholderColor = placeHolderColor
        view.backgroundColor = .clear
        view.textColor = textColor
        view.font = fontSize
        view.delegate = self
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    fileprivate lazy var vPhoto: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(BJAppConstant.loadImageResourcePath("icon-camera"), for: .normal)
        view.tag = IconTextViewType.photo.rawValue
        view.addTarget(self, action: #selector(handleIconClick), for: .touchUpInside)
        return view
    }()
    
    fileprivate let vStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 5
        return view
    }()
    
    fileprivate lazy var vSend: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(BJAppConstant.loadImageResourcePath("icon-send"), for: .normal)
        view.tag = IconTextViewType.send.rawValue
        view.isEnabled = false
        view.addTarget(self, action: #selector(handleIconClick), for: .touchUpInside)
        return view
    }()
    
    fileprivate lazy var vCancel: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "icon-cancel")?.withRenderingMode(.alwaysOriginal), for: .normal)
        view.isHidden = true
        view.tag = IconTextViewType.cancel.rawValue
        view.addTarget(self, action: #selector(handleIconClick), for: .touchUpInside)
        return view
    }()
    
    fileprivate lazy var vUpdate: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Update", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.isHidden = true
        view.tag = IconTextViewType.update.rawValue
        view.addTarget(self, action: #selector(handleIconClick), for: .touchUpInside)
        return view
    }()
    
    fileprivate lazy var vSticker: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(BJAppConstant.loadImageResourcePath("icon-smile")?.withRenderingMode(.alwaysTemplate), for: .normal)
        view.tintColor = .black
        view.tag = IconTextViewType.sticker.rawValue
        view.addTarget(self, action: #selector(handleIconClick), for: .touchUpInside)
        return view
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        vTextView.layer.masksToBounds = true
        if !isMakeCorner {
            vTextView.layer.cornerRadius = vTextView.frame.height / 2
            remakeBottomPadding()
            isMakeCorner = true
        }
    }
    
    fileprivate func remakeBottomPadding() {
        let padding = (self.frame.height / 2) - (iconSize / 2)
        vPhotoBottomConstraint?.constant   = -padding
        vSendBottomConstraint?.constant    = -padding
        vStickerBottomConstraint?.constant = -padding
    }
    
    func updateButton(isUpdate: Bool) {
        vCancel.isHidden = !isUpdate
        vUpdate.isHidden = !isUpdate
        vSend.isHidden = isUpdate
        vPhoto.isEnabled = !isUpdate
        vSticker.isEnabled = !isUpdate
    }
}

extension BJTextViewForm: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        BJCommentData.comment.text = textView.text
        enableSend = BJCommentData.isEnableSend ? true : (textView.text != "")
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimateSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraints) in
            if constraints.firstAttribute == .height {
                if limitSize > estimateSize.height {
                    textView.isScrollEnabled = false
                    constraints.constant = estimateSize.height
                } else {
                    textView.isScrollEnabled = true
                }
            }
        }
    }
    
    // Prevent whitespace for firt character
//    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let whitespaceSet = CharacterSet.whitespaces
//        if range.location == 0 && (text.rangeOfCharacter(from: whitespaceSet) != nil) {
//            return false
//        }
//        return true
//    }
}

extension BJTextViewForm {
    
    @objc func handleIconClick(_ button: UIButton) {
        guard let type = IconTextViewType(rawValue: button.tag) else { return }
        if type == .sticker {
            updateStickerIcon()
        }
        delegate?.handleIconClick(button)
    }
    
    func updateStickerIcon() {
        vSticker.isSelected.toggle()
        if vSticker.isSelected {
            vSticker.tintColor = selectedStickerColor
        } else {
            vSticker.tintColor = unSelectedStickerColor
        }
    }
    
    /** Dismiss Keyboard */
    public func dismissKeyboard() {
        vTextView.resignFirstResponder()
    }
    /** Show Keyboard */
    public func showKeyboard() {
        vTextView.becomeFirstResponder()
    }
}
