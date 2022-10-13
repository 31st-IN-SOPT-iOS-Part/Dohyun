//
//  LoginViewController.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/3/22.
//

import UIKit
import Then

enum LoginMode {
    case login
    case signIn
}

final class LoginViewController: BaseViewController {
    
    // MARK: - UI
    
    private lazy var loginPageTitleLabel = AuthLabelFactory.title(text: "카카오톡을 시작합니다.").build()
    
    private lazy var loginPageDescription: UILabel = AuthLabelFactory.description(text: "사용하던 카카오계정이 있다면\n이메일 또는 전화번호로 로그인해주세요").build()
    
    private lazy var emailTextField = KakaoTextFieldFactory.email(placeholder: "이메일").build()

    private lazy var passwordTextField = KakaoTextFieldFactory.password(placeholder: "비밀번호").build()

    private lazy var passwordCheckTextField = KakaoTextFieldFactory
        .checkPassword(placeholder: "비밀번호 확인").build()

    
    private lazy var loginButton: UIButton = KakaoButtonFactory.defaultButton(title: "카카오계정 로그인") {
        [weak self] _ in
            if self?.mode == .login {
                self?.gotoSignUpViewController()
            } else {
                self?.gotoFinishViewController()
            }
    }.build()
    
    private lazy var signInButton: UIButton = KakaoButtonFactory.defaultButton(title:  "새로운 카카오계정 만들기").build()
    
    
    // iOS 15+ 부터 할 수 있는 방법으로 해보기
    private lazy var findIdOrPasswordButton = KakaoButtonFactory.noBorderButton(title: "카카오계정 또는 비밀번호 찾기").build()
    
    // MARK: -  Private Properties
    private var mode = LoginMode.login {
        didSet {
            loginPageDescription.isHidden = mode == .login ? false : true
        }
    }
    
    // MARK: - Initialization
    
    init(mode: LoginMode) {
        super.init(nibName: nil, bundle: nil)
        self.mode = mode
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

}

// MARK: - Private Function
extension LoginViewController {
    
    // MARK: - UI Configuartion
    private func configureView() {
        
        if mode == .login {
            component += [loginPageTitleLabel, loginPageDescription, emailTextField, passwordTextField, loginButton, signInButton, findIdOrPasswordButton]
        } else {
            component += [loginPageTitleLabel, loginPageDescription, emailTextField, passwordTextField, passwordCheckTextField, signInButton]
            loginPageDescription.isHidden = true
        }
        component.forEach { self.view.addSubview($0) }
        
        
        
    }
    
    // MARK: - Transition Function
    
    private func gotoSignUpViewController() {
        let signUpViewController = AuthFlowViewControllerBuilder.signIn.buildViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    private func gotoFinishViewController() {
        guard let id = emailTextField.text, id != "" else { return }
        let confirmViewController = AuthFlowViewControllerBuilder
            .finish(id: id,
                    transition: { self.navigationController?.popToRootViewController(animated: false)})
            .buildViewController()
        confirmViewController.modalPresentationStyle = .formSheet
        self.present(confirmViewController, animated: true)
    }

}
