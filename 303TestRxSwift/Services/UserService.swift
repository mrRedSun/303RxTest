//
//  UserService.swift
//  303TestRxSwift
//
//  Created by Roman on 8/21/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

class UserService: UserServiceType {
    let successCodes = 200..<300
    func fetchUsers(number: Int) -> Observable<[UserModel]> {
        return RxAlamofire.request(.get, Endpoints.getUsers(number))
            .flatMap {
                $0.validate(statusCode: self.successCodes)
                .rx.data()
            }.map { data -> [UserModel] in
                let remoteUsersArr = try? JSONDecoder().decode([RemoteUserModel].self, from: data)
                let domainArr = remoteUsersArr?.map{ $0.toDomain()}
                
                return domainArr ?? [UserModel]()
        }
    }
}
