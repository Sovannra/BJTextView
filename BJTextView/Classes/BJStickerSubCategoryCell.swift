//
//  BJStickerSubCategoryCell.swift
//  BJTextView
//
//  Created by Sovannra on 20/12/21.
//

import UIKit
import BJCollection

public class BJStickerSubCategoryCell: UICollectionViewCell {
    
    var stickerSubCategory: [StickerSubCategoryModel]? {
        didSet {
            vCollection.reloadData()
        }
    }
    
    var delegate: BJStickerDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(vCollection)
        vCollection.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var vCollection: BJCollectionView = {
        let view = BJCollectionView(numberOfItems: 5, spacingBetweenItems: 3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        view.register(cell: BJStickerCell.self)
        return view
    }()
}

extension BJStickerSubCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickerSubCategory?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BJStickerCell = collectionView.dequeue(for: indexPath)
        cell.imageUrl = stickerSubCategory?[indexPath.row].imageUrl
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sticker = stickerSubCategory?[indexPath.row] else { return }
        delegate?.didSelectStickerItem(sticker)
    }
}
