//
//  LocalDataModel.swift
//  BJTextView_Example
//
//  Created by Sovannra on 23/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import BJTextView

struct LocalDataSticker {
    
    static var stickerData: [StickerCategoryModel] = []
    
    static func loadSticker() {
        let stickerSubCategory = [
            StickerSubCategoryModel(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa3b4cdQbILw7PReqT5Wmw1zmFV9_PW4QbKGmBKu4bTy5rXGol6_HeX2Kkbl40fz0WHTQ&usqp=CAU", stickerId: "1"),
            StickerSubCategoryModel(imageUrl: "https://www.clipartmax.com/png/middle/208-2080291_pastel-color-cute-emotional-stickers-messages-sticker-5-transparent-sticker-cute.png", stickerId: "2")
        ]
        let stickerCategory = [
            StickerCategoryModel(imageUrl: "https://thumbnail.imgbin.com/13/15/18/imgbin-sticker-die-cutting-cat-hello-kitty-cuteness-cat-Lz8tSVA18R6xtEBdbvT9JC2fS_t.jpg", categoryId: "1", subCategory: stickerSubCategory, isSelected: true),
            StickerCategoryModel(imageUrl: "https://www.clipartmax.com/png/middle/254-2542203_cute-cat-stickers-series-cute-sticker-for-birthday.png", categoryId: "2", subCategory: stickerSubCategory),
            StickerCategoryModel(imageUrl: "https://www.clipartmax.com/png/small/396-3960299_simple-happy-birthday-cat-wallpaper-sticker-pusheen-simple-happy-birthday-cat-wallpaper.png", categoryId: "3", subCategory: stickerSubCategory),
            StickerCategoryModel(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkvRzarE8ZLsOYi69xP-trx21BnNjNJQsHEwro60baLYErWyQ_lJ7Wp3iJqkEZnomEGQg&usqp=CAU", categoryId: "4", subCategory: stickerSubCategory),
            StickerCategoryModel(imageUrl: "https://www.kindpng.com/picc/m/147-1472458_pizza-kawaii-emoji-cute-sticker-freetoedit-ftestickers-.png", categoryId: "5", subCategory: stickerSubCategory),
            StickerCategoryModel(imageUrl: "https://img.favpng.com/9/16/13/logo-drawing-computer-icons-png-favpng-YAwrhDgC2Xrn7CjSZx2HTQ5ZG_t.jpg", categoryId: "6", subCategory: stickerSubCategory),
            StickerCategoryModel(imageUrl: "https://i5.walmartimages.com/asr/489cd234-e299-42e5-ab44-738ea8e83716.c9961b0e39b0d37330acfd11f80d2c69.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF", categoryId: "7", subCategory: stickerSubCategory)
        ]
        stickerData = stickerCategory
    }
}
