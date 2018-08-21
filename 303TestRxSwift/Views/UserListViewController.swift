//
//  UserListViewController.swift
//  303TestRxSwift
//
//  Created by Roman on 8/21/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, BindableVcType {
    
    var viewModel: UserListViewModeling!
    
    func bindViewModel() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func onNavigationFinished() {
        self.navigationController?.isNavigationBarHidden = true
    }
}

