//
//  BindableType.swift
//  303TestRxSwift
//
//  Created by Roman on 8/21/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import UIKit

protocol BindableType {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

protocol BindableVcType: BindableType where Self: UIViewController {
    func configureNavigationController()
}

extension BindableVcType {
    mutating func bindViewController(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
        
    }
    
    func configureNavigationController() {
        print("extension hello")
    }
}
extension UIViewController {
    @objc func onNavigationFinished() {
        
    }
}

