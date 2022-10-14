//
//  FinishViewController.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/3/22.
//

import UIKit
import SnapKit
import Then

final class FinishViewController: NiblessViewController {
    
    // MARK: - UI
    private lazy var welcomeMessageLabel = AuthLabelFactory.title(text: "복숭아님\n환영합니다.")
        .build {
            $0.numberOfLines = 2
        }
    
    private lazy var confirmButton = KakaoButtonFactory
        .confirmButton(title: "확인") { [weak self] _ in
            guard let self = self else {return}
            self.gotoLoginViewController()
        }
        .build()
    
    // MARK: - Properties
    private var popNavigation: (()-> Void)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Init
    init(id: String, transition: @escaping ()->Void) {
        self.popNavigation = transition
        super.init()
        self.welcomeMessageLabel.text = "\(id)님\n환영합니다"
    }
    
}

// MARK: - Private Function `

extension FinishViewController {
    
    // MARK: - UI Configuration
    private func configureViews() {
        [welcomeMessageLabel, confirmButton].forEach {
            self.view.addSubview($0)
        }
        setupConstraint()
    }
    
    private func setupConstraint() {
        
        welcomeMessageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height / 4)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding)
            make.height.equalTo(Constant.buttonHeight)
            make.top.equalTo(welcomeMessageLabel.snp.bottom).offset(Constant.bigGap)
        }
        
    }
    
    // MARK: - Transition
    private func gotoLoginViewController() {
        self.popNavigation()
        self.dismiss(animated: true)
    }
    
}


