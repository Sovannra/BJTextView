//
//  StickerModel.swift
//  BJTextView
//
//  Created by Sovannra on 21/12/21.
//

import UIKit

public struct BJCommentModel {
    var commentId: String
    var image: UIImage
    var stickerId: String
    var text: String
    
    public init(commentId: String?=nil, image: UIImage?=nil, stickerId: String?=nil, text: String?=nil) {
        self.commentId = commentId ?? ""
        self.image = image ?? UIImage()
        self.stickerId = stickerId ?? ""
        self.text = text ?? ""
    }
}


public struct StickerCategoryModel {
    let id: String
    let imageUrl: String
    let categoryId: String
    let subCategory: [StickerSubCategoryModel]
    let isSelected: Bool
    
    public init(id: String?=nil, imageUrl: String, categoryId: String, subCategory: [StickerSubCategoryModel], isSelected: Bool?=nil) {
        self.id = id ?? UUID().uuidString
        self.imageUrl = imageUrl
        self.categoryId = categoryId
        self.subCategory = subCategory
        self.isSelected = isSelected ?? false
    }
}

public struct StickerSubCategoryModel {
    let id: String
    let imageUrl: String
    let stickerId: String
    let isSelected: Bool
    
    public init (id: String?=nil, imageUrl: String, stickerId: String) {
        self.id = id ?? UUID().uuidString
        self.imageUrl = imageUrl
        self.stickerId = stickerId
        self.isSelected = false
    }
}
