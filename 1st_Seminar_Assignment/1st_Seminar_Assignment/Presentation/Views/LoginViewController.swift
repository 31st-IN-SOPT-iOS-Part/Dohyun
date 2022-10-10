//
//  LoginViewController.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/3/22.
//

import UIKit

enum LoginMode {
    case login
    case signIn
}

final class LoginViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var loginPageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "카카오톡을 시작합니다"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.sizeToFit()
        label.frame.origin = CGPoint(x: (UIScreen.main.bounds.width - label.bounds.width) / 2, y: 100)
        return label
    }()
    
    private lazy var loginPageDescription: UILabel = {
        let label = UILabel()
        label.text = "사용하던 카카오계정이 있다면\n이메일 또는 전화번호로 로그인해주세요"
        label.textAlignment = .center
        label.numberOfLines  = 2
        label.textColor = .lightGray
        label.sizeToFit()
        label.frame.origin = CGPoint(x: (UIScreen.main.bounds.width - label.bounds.width) / 2, y: loginPageTitleLabel.frame.origin.y + loginPageTitleLabel.frame.height + 30)
        return label
    }()
    
    private lazy var emailTextField = KakaoTextFields
        .email(placeholder: "이메일")
        .build(origin: CGPoint(x: Constant.padding, y: loginPageDescription.frame.origin.y + 60))

    private lazy var passwordTextField = KakaoTextFields
        .password(placeholder: "비밀번호")
        .build(origin: CGPoint(x: Constant.padding, y: emailTextField.frame.origin.y + emailTextField.frame.height + Constant.padding))

    private lazy var passwordCheckTextField = KakaoTextFields
        .checkPassword(placeholder: "비밀번호 확인")
        .build(origin: loginButton.frame.origin)
    
    private lazy var loginButton: UIButton =
        UIButton.makeKakaoButton(title: "카카오계정 로그인",
                            origin: CGPoint(x: Constant.padding, y: passwordTextField.frame.origin.y + passwordTextField.frame.height + 20)) {_ in }
    
    private lazy var signInButton: UIButton = UIButton.makeKakaoButton(title: "새로운 카카오계정 만들기", origin: CGPoint(x: 20, y: loginButton.frame.height + loginButton.frame.origin.y + 20)) { [weak self] _ in
        if self?.mode == .login {
            self?.gotoSignUpViewController()
        } else {
            self?.gotoFinishViewController()
        }
    }
    
    
    // iOS 15+ 부터 할 수 있는 방법으로 해보기
    private lazy var findIdOrPasswordButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "카카오계정 또는 비밀번호 찾기"
        config.titleAlignment = .center
        config.background.cornerRadius = 5
        config.cornerStyle = .dynamic
        config.baseForegroundColor = .lightGray
        let button = UIButton(configuration: config)
        button.sizeToFit()
        button.frame = CGRect(x: (UIScreen.main.bounds.width - button.frame.width) / 2, y: signInButton.frame.origin.y + signInButton.frame.height + Constant.padding, width: button.frame.width, height: button.frame.height)
        return button
    }()
    
    // MARK: -  Private Properties
    private var mode = LoginMode.login
    
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
        view.backgroundColor = .white
        var component: [UIView] = []
        
        if mode == .login {
            component += [loginPageTitleLabel, loginPageDescription, emailTextField, passwordTextField, loginButton, signInButton, findIdOrPasswordButton]
        } else {
            component += [loginPageTitleLabel, loginPageDescription, emailTextField, passwordTextField, passwordCheckTextField, signInButton]
            loginPageDescription.isHidden = true
        }
        
        component.forEach { self.view.addSubview($0)}
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
