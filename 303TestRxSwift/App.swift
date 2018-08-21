//
//  App.swift
//  303TestRxSwift
//
//  Created by Roman on 8/21/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import Foundation
import Foundation
import Swinject
import SwinjectAutoregistration

final class App {
    public static let shared = App()
    public var iocContainer = Container()
    
    private var ioc: Resolver!
    private var window: UIWindow!
    
    
    public var IoC: Resolver {
        if let ioc = self.ioc {
            return ioc
        } else {
            self.syncContainer()
            return ioc
        }
    }
    
    public func syncContainer()  {
        ioc = iocContainer.synchronize()
    }
    
    
    public func run(on window: UIWindow) {
        self.window = window
        registerContainer()
        determineAppStart()
    }
    
    
    private func registerContainer() {
        iocContainer.register(CoordinatorType.self) { _ in return Coordinator(window: self.window!) }
            .inObjectScope(.container)
        
        iocContainer.autoregister(UserListViewModeling.self, initializer: UserListViewModel.init)
    }
    
    private func determineAppStart() {
        let vm = IoC.resolve(UserListViewModeling.self)
        IoC.resolve(CoordinatorType.self)?.transition(to: .userList(vm!), type: .root)
    }
    
    private init() {
    }
}




