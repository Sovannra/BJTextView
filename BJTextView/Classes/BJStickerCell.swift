//
//  BJStickerCell.swift
//  BJTextView
//
//  Created by Sovannra on 21/12/21.
//

import UIKit
import BJCollection

class BJStickerCell: UICollectionViewCell {
    
    var imageUrl: String? {
        didSet {
            vImage.loadImage(with: imageUrl ?? "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap = UITapGestureRecognizer(target: self, action:nil)
        self.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        backgroundColor = .clear
        addSubview(vImage)
        addSubview(vLine)
        vImage.fillSuperview(padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        vLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        vLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        vLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var vImage: UIImageView = {
        let view = UIImageView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let vLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        view.isHidden = true
        return view
    }()
}
