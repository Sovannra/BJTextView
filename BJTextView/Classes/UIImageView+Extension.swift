//
//  UIImageView+Extension.swift
//  BJTextView
//
//  Created by Sovannra on 23/12/21.
//

import UIKit
import Nuke

extension UIImageView {
    
    /** Load image from url */
    public func loadImage(with url: String, placeholder: String?="", completion: ImageTask.Completion? = nil) {
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: placeholder ?? ""),
            transition: .fadeIn(duration: 0.33)
        )
        if let url = URL(string: url) {
            Nuke.loadImage(with: url, options: options, into: self, completion: completion)
        }
    }
    
   public var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}
