//
//  BJImageContainer.swift
//  BJTextView
//
//  Created by Sovannra on 22/12/21.
//

import UIKit
import BJCollection
import DKImagePickerController

public class BJImageContainer: UIView {
    
    var image: UIImage? {
        didSet {
            containerSize = BJAppConstant.containerWidth(image)
            updateLayout()
            self.vImage.image = image
            
        }
    }
    
    public var containerSize: CGFloat = 100
    public let iconSize: CGFloat = 20
    public var iconName: String = "" {
        didSet {
            vClear.setImage(UIImage(named: iconName), for: .normal)
        }
    }
    
    fileprivate var vImageTop: NSLayoutConstraint?
    fileprivate var vImageWidth: NSLayoutConstraint?
    fileprivate var vImageHeight: NSLayoutConstraint?
    
    fileprivate var vClearWidth: NSLayoutConstraint?
    fileprivate var vClearHeight: NSLayoutConstraint?
    
    var clearPhotoClourse: (() -> Void)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        setupComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func updateLayout() {
        vClearWidth?.constant = iconSize
        vClearHeight?.constant = iconSize
        vClear.isHidden = false
        vImageTop?.constant = 10
        vImageWidth?.constant = containerSize
        vImageHeight?.constant = BJAppConstant.calculateAspect(containerSize, image: image)
    }
    
    func removeImage() {
        vImageTop?.constant = 0
        vImageWidth?.constant = 0
        vImageHeight?.constant = 0
        vClearWidth?.constant = 0
        vClearHeight?.constant = 0
        vClear.isHidden = true
        vImage.image = nil
        clearPhotoClourse?()
    }
    
    fileprivate func setupComponent() {
        addSubview(vImage)
        addSubview(vClear)
        
        // vImage
        vImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        vImageWidth = vImage.widthAnchor.constraint(equalToConstant: 0)
        vImageWidth?.isActive = true
        vImageHeight = vImage.heightAnchor.constraint(equalToConstant: 0)
        vImageHeight?.isActive = true
        vImageTop = vImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        vImageTop?.isActive = true
        
        vClear.topAnchor.constraint(equalTo: vImage.topAnchor).isActive = true
        vClear.rightAnchor.constraint(equalTo: vImage.rightAnchor, constant: 30).isActive = true
        vClearWidth = vClear.widthAnchor.constraint(equalToConstant: 0)
        vClearWidth?.isActive = true
        vClearHeight = vClear.heightAnchor.constraint(equalToConstant: 0)
        vClearHeight?.isActive = true
    }
    
    let vImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var vClear: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.setImage(BJAppConstant.loadImageResourcePath("icon-clear"), for: .normal)
        view.addTarget(self, action: #selector(handleIconClick), for: .touchUpInside)
        return view
    }()
    
    @objc fileprivate func handleIconClick() {
        removeImage()
    }
}
