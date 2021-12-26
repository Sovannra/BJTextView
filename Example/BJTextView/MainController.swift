//
//  MainController.swift
//  BJTextView_Example
//
//  Created by Sovannra on 24/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let vButton = UIButton()
        vButton.backgroundColor = .systemBlue
        vButton.translatesAutoresizingMaskIntoConstraints = false
        vButton.setTitle("Click me", for: .normal)
        vButton.addTarget(self, action: #selector(pushMe), for: .touchUpInside)
        
        view.addSubview(vButton)
        vButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        vButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        vButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc func pushMe() {
        navigationController?.pushViewController(ViewController(), animated: true)
    }
}
