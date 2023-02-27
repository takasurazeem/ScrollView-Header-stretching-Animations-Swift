//
//  MainViewController.swift
//  ScrollView-Header-stretching-Animations-Swift
//
//  Created by Takasur Azeem on 27/02/2023.
//  Copyright © 2023 Sanket Vaghela. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Testing")
        view.backgroundColor = .white
        let scrollableView = ScrollableView()
        scrollableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollableView)
        scrollableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
