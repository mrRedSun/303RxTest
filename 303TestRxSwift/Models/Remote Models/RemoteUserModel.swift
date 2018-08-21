//
//  RemoteUserModel.swift
//  303TestRxSwift
//
//  Created by Roman on 8/21/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import Foundation

class RemoteUserModel: Decodable {
    var fname: String?
    var lname: String?
    var city: String?
}

extension RemoteUserModel: RemoteModelType {
    func toDomain() -> UserModel {
        let model = UserModel()
        
        model.firstName = self.fname
        model.lastName = self.lname
        model.city = self.city
        
        return model
    }
}
