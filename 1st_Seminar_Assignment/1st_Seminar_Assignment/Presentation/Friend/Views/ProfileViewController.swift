//
//  ProfileViewController.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/13/22.
//

import UIKit

final class ProfileViewController: NiblessViewController {
    
    // MARK: - UI Properties
    
    private lazy var navigationBar = KakaoNavigationViewFactory.home(navTitle: nil,
                                                                     barViews: [.xbutton(color: .white), .flexibleView],
                                                                     completions: [{ [unowned self] _ in self.dismiss(animated: true)}])
        .build()
    
    
    private lazy var profileImage = KakaoButtonFactory.profileButton(image: UIImage(named: "profile_userImg")!, completion: nil).build()
    
    private lazy var profileNameLabel = KakaoLabelFactory.name(text: "김솝트").build()
    
    private lazy var divider = UIView.makeDivider()
    
    private lazy var profileButtonStackView: UIStackView = {
        var buttons = KakaoButtonFactory.KakaoButtonIcon.allCases.map { icon -> UIButton in
            let button = KakaoButtonFactory.iconButton(icon: icon, title: icon.rawValue).build{
                $0.configuration?.baseForegroundColor = .white
                $0.configuration?.imagePadding = Constant.ProfileConstant.buttonImagePadding
            }
            return button
        }
        let stackview = UIStackView(arrangedSubviews: buttons).then {
            $0.alignment = .fill
            $0.distribution = .fill
            $0.axis = .horizontal
        }
        return stackview
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        configureView()
    }
    
}

// MARK: - UI Setting

extension ProfileViewController {
    
    private func configureView() {
        component += [navigationBar, profileImage, profileNameLabel, divider, profileButtonStackView]
        component.forEach { self.view.addSubview($0)}
        setupConstraint()
    }
    
    private func setupConstraint() {
        
        navigationBar.snp.makeConstraints { make in
            make.height.equalTo(Constant.navigationBarHeight)
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileImage.snp.makeConstraints { make in
            make.height.width.equalTo(Constant.ProfileConstant.imageSize)
            make.top.equalTo(view.snp.top).offset(514.adjusted)
            make.centerX.equalToSuperview()
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImage.snp.bottom).offset(8.adjusted)
        }
        
        divider.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(profileImage.snp.bottom).offset(70.adjusted)
        }
        
        profileButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(33.adjusted)
            make.centerX.equalToSuperview()
        }
        
        
    }
}
