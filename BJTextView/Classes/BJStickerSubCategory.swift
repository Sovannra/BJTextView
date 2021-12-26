//
//  BJStickerSubCategory.swift
//  BJTextView
//
//  Created by Sovannra on 20/12/21.
//

import UIKit
import BJCollection

class BJStickerSubCategory: UIView {
    
    var stickerCategory: [StickerCategoryModel]? {
        didSet {
            vCollection.reloadData()
        }
    }
    
    var delegate: BJStickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(vCollection)
        vCollection.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var vCollection: BJCollectionView = {
        let view = BJCollectionView(numberOfItems: 1, spacingBetweenItems: 0, scrollDirection: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(cell: BJStickerSubCategoryCell.self)
        view.backgroundColor = .clear
        view.isPagingEnabled = true
        view.showScrollIndicator = false
        view.bounces = false
        return view
    }()
}

extension BJStickerSubCategory: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickerCategory?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BJStickerSubCategoryCell = collectionView.dequeue(for: indexPath)
        cell.stickerSubCategory = stickerCategory?[indexPath.row].subCategory
        cell.delegate = self
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = vCollection.contentOffset
        visibleRect.size = vCollection.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = vCollection.indexPathForItem(at: visiblePoint) else { return }
        
        delegate?.didScrollCategory(indexPath.row)
    }
}

extension BJStickerSubCategory {
    
    func scrollToItemAtIndex(_ index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        vCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension BJStickerSubCategory: BJStickerDelegate {
    func didSelectCategoryItem(_ index: Int) {
        
    }
    
    func didScrollCategory(_ index: Int) {
        
    }
    
    func didSelectStickerItem(_ sticker: StickerSubCategoryModel) {
        delegate?.didSelectStickerItem(sticker)
    }
}
