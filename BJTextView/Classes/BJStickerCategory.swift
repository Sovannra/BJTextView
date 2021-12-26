//
//  BJStickerHeader.swift
//  BJTextView
//
//  Created by Sovannra on 20/12/21.
//

import UIKit
import BJCollection

public class BJStickerCategory: UIView {
    
    var stickerCategory: [StickerCategoryModel]? {
        didSet {
            vCollection.reloadData()
        }
    }
    
    public let selectColor: UIColor = .systemOrange
    
    // To set line color under item by index
    fileprivate var itemAtIndex: Int = 0 {
        didSet {
            vCollection.reloadData()
        }
    }
    
    var delegate: BJStickerDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(vCollection)
        vCollection.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var vCollection: BJCollectionView = {
        let view = BJCollectionView(numberOfItems: 1, widthItems: 60, spacingBetweenItems: 3, scrollDirection: .horizontal)
        view.showScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(cell: BJStickerCell.self)
        view.backgroundColor = .clear
        view.bounces = false
        return view
    }()
}

extension BJStickerCategory: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickerCategory?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BJStickerCell = collectionView.dequeue(for: indexPath)
        cell.imageUrl = stickerCategory?[indexPath.row].imageUrl ?? ""
        cell.vLine.backgroundColor = selectColor
        cell.vLine.isHidden = indexPath.row == itemAtIndex ? false : true
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemAtIndex = indexPath.row
        delegate?.didSelectCategoryItem(indexPath.row)
    }
}

extension BJStickerCategory {
    func scrollToItemAtIndex(_ index: Int) {
        itemAtIndex = index
        let indexPath = IndexPath(row: index, section: 0)
        vCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
