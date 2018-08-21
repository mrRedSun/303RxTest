//
//  RemoteModelType.swift
//  303TestRxSwift
//
//  Created by Roman on 8/21/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import Foundation

protocol RemoteModelType {
    associatedtype LocalModelType
    
    func toDomain() -> LocalModelType
}
