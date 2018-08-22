//
//  UserListViewModel.swift
//  303TestRxSwift
//
//  Created by Roman on 8/21/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class UserListViewModel: UserListViewModeling {
    typealias SectionModel = AnimatableSectionModel<String, UserModel>
    private let coordinator: CoordinatorType
    private let userService: UserServiceType
    private var disposeBag: DisposeBag! = DisposeBag()
    
    let usersSubject = PublishSubject<[UserModel]>()
    
    public let userSectionSource: Observable<[SectionModel]>
    public let numberOfUsers = PublishRelay<Int>()
    public let isBusySubject = PublishSubject<Bool>()
    
    init(coordinator: CoordinatorType, userService: UserServiceType) {
        self.coordinator = coordinator
        self.userService = userService
        
        userSectionSource = usersSubject.map { users in
            let sections = [SectionModel(model: "", items: users)]
            return sections
        }
        
        setupViewModel()
    }
    
    private func setupViewModel() {
        numberOfUsers.asObservable()
            .throttle(2, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { [unowned self] _ in self.isBusySubject.onNext(true) })
            .flatMap {  [unowned self] in self.userService.fetchUsers(number: $0) }
            .map { $0.sorted {$0.firstName! < $1.firstName!} }
            .do(onNext: { [unowned self] _ in self.isBusySubject.onNext(false)} )
            .bind(to: usersSubject)
            .disposed(by: disposeBag)
    }
}
