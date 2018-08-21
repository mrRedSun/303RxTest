//
//  Coordinator.swift
//  InstagroomRxMVVM
//
//  Created by Roman on 7/27/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class Coordinator : CoordinatorType {
    private var _navigationController: UINavigationController!
    private let _window: UIWindow
    
    required init(window: UIWindow) {
        _window = window
    }
    
    @discardableResult
    func pop(animated: Bool) -> Observable<Void> {
        guard _navigationController != nil else {
            fatalError("Can't navigate back without navigation controller")
        }
        
        let subject = PublishSubject<Void>()
        
        if let presentedVC = _navigationController.presentedViewController {
            presentedVC.dismiss(animated: animated) {
                subject.onCompleted()
            }
        } else {
            _ = _navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
            
            guard _navigationController.popViewController(animated: animated) != nil else {
                fatalError("Can't navigate back from \(String(describing: _navigationController))")
            }
        }
        
        return subject.asObservable()
            .takeLast(1)
    }
    
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void> {
        guard (type == .root || _navigationController != nil) else {
            fatalError("Can't transition without root navigation controller")
        }
        
        let subject = PublishSubject<Void>()
        let viewController = scene.resolveViewController()
        
        
        switch type {
        case .modal:
            _navigationController.present(viewController, animated: true) {
                subject.onCompleted()
            }
            
        case .push:
            _ = _navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
            
            _navigationController.pushViewController(viewController, animated: true)
            
        case .root:
            _navigationController = UINavigationController(rootViewController: viewController)
            _navigationController.loadView()
            
            
            UIView.transition(with: _window, duration: 3,
                              options: .curveEaseInOut,
                              animations: { [unowned self] in self._window.rootViewController = self._navigationController},
                              completion: { _ in subject.onCompleted() })
        }
        
        viewController.onNavigationFinished()
        
        return subject.asObservable()
            .take(1)
    }
}







