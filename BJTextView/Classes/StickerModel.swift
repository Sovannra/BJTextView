//
//  StickerModel.swift
//  BJTextView
//
//  Created by Sovannra on 21/12/21.
//

public enum BJCommentTextType: String, CaseIterable {
    case caption = "caption"
    case image   = "image"
    case sticker = "sticker"
}

public struct BJCommentModel {
    public var commentId: String
    public var image: UIImage
    public var imageUrl: String
    public var stickerId: String
    public var text: String
    public var type: BJCommentTextType
    public var indexPath: Int
    public var createdAt: Double
    
    public init(commentId: String?=nil, image: UIImage?=nil, imageUrl: String?=nil, stickerId: String?=nil, text: String?=nil, type: BJCommentTextType?=nil, indexPath: Int?=nil, createdAt: Double?=nil) {
        self.commentId = commentId ?? ""
        self.image = image ?? UIImage()
        self.imageUrl = imageUrl ?? ""
        self.stickerId = stickerId ?? ""
        self.text = text ?? ""
        self.type = type ?? .caption
        self.indexPath = indexPath ?? 0
        self.createdAt = createdAt ?? Date().timeIntervalSince1970
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

