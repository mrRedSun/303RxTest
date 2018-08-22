//
//  UserListViewController.swift
//  303TestRxSwift
//
//  Created by Roman on 8/21/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class UserListViewController: UIViewController, BindableVcType {
    @IBOutlet weak var userCountLabel: UILabel!
    @IBOutlet weak var userCountSlider: UISlider!
    @IBOutlet weak var usersTableView: UITableView!
    
    let userCellId = "UserCell"
    
    var activityIndicator: UIActivityIndicatorView!
    
    typealias SectionModel = AnimatableSectionModel<String, UserModel>

    var viewModel: UserListViewModeling!
    var disposeBag = DisposeBag()
    
    func bindViewModel() {
        userCountSlider.rx.value
            .map { Int($0.rounded()) }
            .bind(to: viewModel.numberOfUsers)
            .disposed(by: disposeBag)
        
        userCountSlider.rx.value
            .map { "Current user count: \(Int($0.rounded()))" }
            .bind(to: userCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.isBusySubject
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        setupTableView()
    }
    
    func setupTableView() {
        usersTableView.register(UITableViewCell.self, forCellReuseIdentifier: userCellId)
        
        let dataSourse = RxTableViewSectionedAnimatedDataSource<SectionModel>(configureCell: {
            [unowned self] dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.userCellId)
            
            cell?.textLabel?.text = item.firstName! + " " + item.lastName!
            cell?.detailTextLabel?.text = item.city!
            
            return cell!
        })
        
        viewModel.userSectionSource.bind(to: usersTableView.rx.items(dataSource: dataSourse)).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        view.bringSubview(toFront: activityIndicator)

        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func onNavigationFinished() {
        self.navigationController?.isNavigationBarHidden = true
    }
}

