//
//  Scene+ViewController.swift
//  InstagroomRxMVVM
//
//  Created by Roman on 7/27/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import Foundation
import UIKit

extension Scene {
    func resolveViewController() -> UIViewController {
        switch(self) {
        case .userList(let vm):
            return resolveUserListView(vm)
        }
    }
    
    private func resolveUserListView(_ viewModel: UserListViewModeling) -> UserListViewController {
        var vc = UserListViewController(nibName: "UserListViewController", bundle: nil)
        vc.bindViewController(to: viewModel)
        
        return vc
    }
}
