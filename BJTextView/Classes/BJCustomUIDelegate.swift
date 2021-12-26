//
//  BJCustomUIDelegate.swift
//  BJTextView
//
//  Created by Sovannra on 23/12/21.
//

import UIKit
import DKImagePickerController

open class CustomUIDelegate: DKImagePickerControllerBaseUIDelegate {
          
    override open func createDoneButtonIfNeeded() -> UIButton {
        if self.doneButton == nil {
            let button = UIButton(type: .custom)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.setTitleColor(UIColor(red: 85 / 255.0, green: 184 / 255.0, blue: 44 / 255.0, alpha: 1.0), for: .normal)
            button.setTitleColor(UIColor(red: 85 / 255.0, green: 184 / 255.0, blue: 44 / 255.0, alpha: 0.4), for: .disabled)
            button.addTarget(self.imagePickerController, action: #selector(DKImagePickerController.done), for: .touchUpInside)
            self.doneButton = button
        }
        
        return self.doneButton!
    }
    
    override open func prepareLayout(_ imagePickerController: DKImagePickerController, vc: UIViewController) {
        self.imagePickerController = imagePickerController
    }
    
    override open func imagePickerController(_ imagePickerController: DKImagePickerController,
                                               showsCancelButtonForVC vc: UIViewController) {
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                               target: imagePickerController,
                                                               action: #selector(imagePickerController.dismiss as () -> Void))
    }
    
    override open func imagePickerController(_ imagePickerController: DKImagePickerController,
                                               hidesCancelButtonForVC vc: UIViewController) {
        vc.navigationItem.rightBarButtonItem = nil
    }
    
    open override func imagePickerControllerCollectionImageCell() -> DKAssetGroupDetailBaseCell.Type {
        return CustomGroupDetailImageCell.self
    }
}
