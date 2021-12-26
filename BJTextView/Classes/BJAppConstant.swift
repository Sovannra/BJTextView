//
//  BJImageView+Extension.swift
//  BJTextView
//
//  Created by Sovannra on 22/12/21.
//

import UIKit
import DKImagePickerController

public struct BJAppConstant {
    
    public static func getBottomSafeAreaHeight() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.bottom ?? 0
            return bottomPadding
        }
        return 0
    }
    
    public static func containerWidth(_ image: UIImage?) -> CGFloat {
        return (image?.cgImage?.height ?? 0) < (image?.cgImage?.width ?? 0) ? 150 : 100
    }
    
    public static func loadImageResourcePath(_ fileName: String) -> UIImage? {
        let bundle = Bundle(for: BJTextViewForm.self)
        return UIImage(named: fileName, in: bundle, compatibleWith: nil)
    }
    
    public static func calculateAspect(_ width: CGFloat, image: UIImage?) -> CGFloat {
        guard let imageReact = image?.cgImage else { return 0 }
        
        // Square
        if imageReact.height == imageReact.width {
            return width
        }
        // Landscape
        if imageReact.height < imageReact.width {
            let aspectRadio: CGFloat = 4 / 6
            let height = width * aspectRadio
            return height
        }
        // Portrait
        if imageReact.height > imageReact.width {
            let aspectRadio: CGFloat = 4 / 3
            let height = width * aspectRadio
            return height
        }
        
        return width
    }
}

// BJSticker Protocol
public protocol BJStickerDelegate {
    /** select item on category to move subCategory item */
    func didSelectCategoryItem(_ index: Int)
    /** scroll item on subCategory to move category item */
    func didScrollCategory(_ index: Int)
    /** select sticker on subCategory item */
    func didSelectStickerItem(_ sticker: StickerSubCategoryModel)
}

// BJComment Model
public struct BJCommentData {
    public static var comment: BJCommentModel = BJCommentModel()
}

public protocol BJCommentDelegate {
    func sendComment(_ comment: BJCommentModel)
    func didSelectSticker(_ isSelected: Bool)
}
