//
//  FriendTableViewController.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/13/22.
//

import UIKit

final class FriendTableViewController: NiblessViewController {
    
    
    lazy var navigationBar = KakaoNavigationViewFactory.home(navTitle: "친구", barViews: [.setting, .setting, .flexibleView, ]).build()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override init() {
        super.init()
    }

}

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
