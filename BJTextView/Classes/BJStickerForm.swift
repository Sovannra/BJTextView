//
//  BJStickerForm.swift
//  BJTextView
//
//  Created by Sovannra on 20/12/21.
//

import UIKit
import BJCollection

public class BJStickerForm: UIView {
    
    public var stickerData: [StickerCategoryModel]? {
        didSet {
            vStickerCategory.stickerCategory = stickerData
            vStickerSubCategory.stickerCategory = stickerData
        }
    }
    public var vStickerCategoryHeight: NSLayoutConstraint?
    public var heightItem: CGFloat = 60
    var delegate: BJStickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupComponent() {
        addSubview(vContainer)
        vContainer.addArrangedSubview(vStickerCategory)
        vContainer.addArrangedSubview(vStickerSubCategory)
        
        // vContainer
        vContainer.fillSuperview()
        
        // vStickerCategory
        vStickerCategoryHeight = vStickerCategory.heightAnchor.constraint(equalToConstant: 0)
        vStickerCategoryHeight?.isActive = true
        
    }
    
    let vContainer: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.axis = .vertical
        view.distribution = .fill
        return view
    }()
    
    lazy var vStickerCategory: BJStickerCategory = {
        let view = BJStickerCategory()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    lazy var vStickerSubCategory: BJStickerSubCategory = {
        let view = BJStickerSubCategory()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
}

extension BJStickerForm {
    public func updateStickerCategoryLayout(_ isShow: Bool) {
        vStickerCategoryHeight?.constant = isShow ? heightItem : 0
    }
}

extension BJStickerForm: BJStickerDelegate {
    public func didSelectCategoryItem(_ index: Int) {
        vStickerSubCategory.scrollToItemAtIndex(index)
    }
    
    public func didScrollCategory(_ index: Int) {
        vStickerCategory.scrollToItemAtIndex(index)
    }
    
    public func didSelectStickerItem(_ sticker: StickerSubCategoryModel) {
        delegate?.didSelectStickerItem(sticker)
    }
}
