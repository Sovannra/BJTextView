//
//  BJCommentTextView.swift
//  BJTextView
//
//  Created by Sovannra on 21/12/21.
//

import UIKit
import Photos
import AVKit
import DKImagePickerController

public class BJCommentTextView: UIView {
    
    public var stickerData: [StickerCategoryModel]? {
        didSet {
            vStickerForm.stickerData = stickerData
        }
    }
    
    public let borderWidth: CGFloat = 0.5
    public let borderColor: UIColor = .lightGray
    
    public var delegate: BJCommentDelegate?
    
    fileprivate var keyboardHeight: CGFloat {
        return KeyboardService.keyboardHeight() - BJAppConstant.getBottomSafeAreaHeight()
    }
    
    fileprivate var pickerController = DKImagePickerController()
    fileprivate var vStickerBottomConstraint: NSLayoutConstraint?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        setupComponent()
        configImagePicker()
        clearImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupComponent() {
        
        addSubview(vImageContainer)
        addSubview(vTextViewForm)
        addSubview(vStickerForm)
        
        // vImage
        vImageContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        vImageContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 45).isActive = true
        vImageContainer.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        // vTextViewForm
        vTextViewForm.topAnchor.constraint(equalTo: vImageContainer.bottomAnchor).isActive = true
        vTextViewForm.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vTextViewForm.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        // vStickerForm
        vStickerForm.topAnchor.constraint(equalTo: vTextViewForm.bottomAnchor).isActive = true
        vStickerForm.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vStickerForm.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        vStickerForm.heightAnchor.constraint(equalToConstant: keyboardHeight).isActive = true
        vStickerBottomConstraint = vStickerForm.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: keyboardHeight)
        vStickerBottomConstraint?.isActive = true
    }

    public lazy var vTextViewForm: BJTextViewForm = {
        let view = BJTextViewForm()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    public lazy var vStickerForm: BJStickerForm =  {
        let view = BJStickerForm()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.delegate = self
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    public let vImageContainer: BJImageContainer = {
        let view = BJImageContainer()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
}

extension BJCommentTextView {
    
    public func popupKeyboard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
            vTextViewForm.showKeyboard()
        }
    }
    
    public func dismissKeyboard() {
        vTextViewForm.dismissKeyboard()
    }
    
    public func updateComment(_ comment: BJCommentModel) {
        vTextViewForm.updateButton(isUpdate: true)
        vTextViewForm.showKeyboard()
        BJCommentData.comment = comment
        vTextViewForm.textStr = comment.text
    }
    
    fileprivate func showImage(_ image: UIImage?) {
        self.vImageContainer.image = image
        BJCommentData.comment.image = image ?? UIImage()
        vTextViewForm.enableSend = BJCommentData.isEnableSend
    }
    
    fileprivate func configImagePicker() {
        pickerController.singleSelect = true
        pickerController.autoCloseOnSingleSelect = true
        pickerController.assetType = .allPhotos
        pickerController.showsEmptyAlbums = false
        pickerController.UIDelegate = CustomUIDelegate()
        pickerController.showsCancelButton = true
    }
    
    fileprivate func showImagePicker() {
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            self.updateAssets(assets: assets)
        }
        let viewController = UIApplication.shared.keyWindow!.rootViewController!
        pickerController.modalPresentationStyle = .fullScreen
        viewController.present(pickerController, animated: true) {}
    }
    
    fileprivate func clearImage() {
        vImageContainer.clearPhotoClourse = {
            BJCommentData.comment.image = UIImage()
            BJCommentData.comment.stickerId = ""
            self.vTextViewForm.enableSend = BJCommentData.isEnableSend
        }
    }
    
    fileprivate func updateAssets(assets: [DKAsset]) {
        guard let asset = assets.first else { return }
        asset.fetchImage(with: vImageContainer.intrinsicContentSize.toPixel(), completeBlock: { image, info in
            self.showImage(image)
            BJCommentData.comment.stickerId = ""
            self.vTextViewForm.showKeyboard()
        })
    }
    
    func showHideStickerForm(_ isSelected: Bool) {
        vStickerForm.updateStickerCategoryLayout(isSelected)
        vStickerBottomConstraint?.constant = isSelected ? 0 : keyboardHeight
        vStickerForm.isHidden = !isSelected
        vStickerForm.alpha = isSelected ? 1 : 0
    }
    
    public func resetSticker() {
        vTextViewForm.isSelected = false
        vTextViewForm.updateStickerIcon()
        showHideStickerForm(false)
    }
    
    private func clearComment() {
        BJCommentData.comment = BJCommentModel()
        vImageContainer.removeImage()
        vTextViewForm.textStr = ""
        vTextViewForm.updateButton(isUpdate: false)
    }
}

extension BJCommentTextView: BJTextViewDelegate {
    public func handleIconClick(_ button: UIButton) {
        guard let type = IconTextViewType(rawValue: button.tag) else { return }
        switch type {
        case .photo:
            showImagePicker()
        case .sticker:
            showHideStickerForm(button.isSelected)
            if button.isSelected {
                dismissKeyboard()
            } else {
                vTextViewForm.showKeyboard()
            }
            delegate?.didSelectSticker(button.isSelected)
        case .send:
            BJCommentData.comment.type = BJCommentData.type
            delegate?.sendComment(BJCommentData.comment)
            clearComment()
        case .update:
            BJCommentData.comment.type = BJCommentData.type
            delegate?.updateComment(BJCommentData.comment)
            clearComment()
        case .cancel:
            clearComment()
        }
    }
}

extension BJCommentTextView: BJStickerDelegate {
    public func didSelectCategoryItem(_ index: Int) {
        
    }
    
    public func didScrollCategory(_ index: Int) {
        
    }
    
    public func didSelectStickerItem(_ sticker: StickerSubCategoryModel) {
        let vImage = UIImageView()
        vImage.loadImage(with: sticker.imageUrl)
        BJCommentData.comment.stickerId = sticker.stickerId
        showImage(vImage.image)
    }
}
