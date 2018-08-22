//
//  UserListViewModeling.swift
//  303TestRxSwift
//
//  Created by Roman on 8/21/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources
protocol UserListViewModeling {
    typealias SectionModel = AnimatableSectionModel<String, UserModel>
    
    var numberOfUsers: PublishRelay<Int> { get }
    var userSectionSource: Observable<[SectionModel]> { get }
    var isBusySubject: PublishSubject<Bool> { get }
}
