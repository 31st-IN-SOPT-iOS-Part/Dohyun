//
//  FriendTableViewController.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/13/22.
//

import UIKit

final class FriendTableViewController: NiblessViewController {
    
    // MARK: - UI Properties
    
    private lazy var navigationBar = KakaoNavigationViewFactory.home(
        barViews: [.flexibleView, .label(content: UILabel().then({
            $0.text = "HELLO"
            $0.font = .preferredFont(forTextStyle: .title1)
        })), .flexibleView]).build()
    
    private lazy var profileView = KakaoButtonFactory.profileButton(image: UIImage(named: "profile_userImg")!) { _ in
        let vc = ProfileViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }.build()

    
    // MARK: - LifeCycle & Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationBar.subviews[0].subviews.forEach{ print($0.frame.width)}
    }
    
    
    override init() {
        super.init()
    }

}


// MARK: - Setting UI

extension FriendTableViewController {
    
    private func configureView() {
        component += [navigationBar, profileView]
        component.forEach { view.addSubview($0)}
        setupConstraint()
    }
    
    private func setupConstraint() {
        navigationBar.snp.makeConstraints { make in
            make.height.equalTo(Constant.navigationBarHeight)
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.padding)
            make.top.equalTo(navigationBar.snp.bottom).offset(Constant.bigGap)
            make.width.height.equalTo(Constant.profileImageHeight)
        }
    }
}
