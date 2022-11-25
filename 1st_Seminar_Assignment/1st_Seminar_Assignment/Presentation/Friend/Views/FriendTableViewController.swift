//
//  FriendTableViewController.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/13/22.
//

import UIKit

struct Friend {
    var imageURL: String?
    var name: String
    var description: String?
}

final class FriendTableViewController: NiblessViewController {
    
    // MARK: - UI Properties
    
    private lazy var navigationBar = KakaoNavigationViewFactory.home(
        barViews: [.flexibleView, .title(content: "HELLO"),.flexibleView]).build()
    
    private lazy var friendTableView: UITableView = {
       let tableview = UITableView()
        return tableview
    }()
    
    private var datasource: UITableViewDiffableDataSource<Int, UUID>!

    
    // MARK: - LifeCycle & Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override init() {
        super.init()
    }

}


// MARK: - Setting UI

extension FriendTableViewController {
    
    private func configureView() {
        component += [navigationBar]
        component.forEach { view.addSubview($0)}
        setupConstraint()
    }
    
    private func setupConstraint() {
        navigationBar.snp.makeConstraints { make in
            make.height.equalTo(Constant.navigationBarHeight)
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
