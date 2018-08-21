//
//  CoordinatorType.swift
//  InstagroomRxMVVM
//
//  Created by Roman on 7/27/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import Foundation

import UIKit
import RxSwift

protocol CoordinatorType {
    init(window: UIWindow)
    
    /// transition to another scene
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void>
    
    /// pop scene from navigation stack or dismiss current modal
    @discardableResult
    func pop(animated: Bool) -> Observable<Void>
}

extension CoordinatorType {
    @discardableResult
    func pop() -> Observable<Void> {
        return pop(animated: true)
    }
}
