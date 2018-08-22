//
//  UserModel.swift
//  303TestRxSwift
//
//  Created by Roman on 8/21/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import Foundation
import RxDataSources

class UserModel {
    var firstName: String?
    var lastName: String?
    var city: String?
}

extension UserModel: Equatable, IdentifiableType {
    var identity: String {
        get {
            return firstName! + lastName! + city!
        }
    }
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.firstName! > rhs.firstName!
    }


}
