//
//  LoginViewController.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/3/22.
//

import UIKit
import SnapKit
import Then

enum LoginMode {
    case login
    case signIn
}

final class LoginViewController: NiblessViewController {
    
    // MARK: - UI Properties
    
    private lazy var loginPageTitleLabel = KakaoLabelFactory
        .title(text: "카카오톡을 시작합니다.")
        .build()
    
    private lazy var loginPageDescription: UILabel = KakaoLabelFactory
        .description(text: "사용하던 카카오계정이 있다면\n이메일 또는 전화번호로 로그인해주세요")
        .build()
    
    private lazy var emailTextField = KakaoTextFieldFactory
        .email(placeholder: "이메일", borderStyle: .underline)
        .build()

    private lazy var passwordTextField = KakaoTextFieldFactory
        .password(placeholder: "비밀번호", borderStyle: .underline)
        .build()

    private lazy var passwordCheckTextField = KakaoTextFieldFactory
        .checkPassword(placeholder: "비밀번호 확인", borderStyle: .underline)
        .build()
        
    private lazy var loginButton: UIButton = KakaoButtonFactory
        .defaultButton(title: "카카오계정 로그인")
        .build()
    
    private lazy var signInButton: UIButton = KakaoButtonFactory
        .defaultButton(title:  "새로운 카카오계정 만들기"){
            [weak self] _ in self?.mode == .login ? self?.gotoSignUpViewController() : self?.gotoFinishViewController()}
        .build()
    
    
    // iOS 15+ 부터 할 수 있는 방법으로 해보기
    private lazy var findIdOrPasswordButton = KakaoButtonFactory
        .noBorderButton(title: "카카오계정 또는 비밀번호 찾기")
        .build()
    
    // MARK: -  Private Properties
    private var mode = LoginMode.login
    
    // MARK: - Initialization
    
    init(mode: LoginMode) {
        super.init()
        self.mode = mode
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
        component += [loginPageTitleLabel, loginPageDescription, emailTextField, passwordTextField, loginButton, signInButton, findIdOrPasswordButton, passwordCheckTextField]
        component.forEach { self.view.addSubview($0) }
        setupConstraint()
    }
    
    // MARK: - UI Autolayout
    
    private func setupConstraint() {
        
        loginPageTitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constant.bigGap)
        }
        
        loginPageDescription.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding)
            make.top.equalTo(loginPageTitleLabel.snp.bottom).offset(Constant.bigGap)
            if mode == .signIn {
                make.height.equalTo(0)
            }
        }
        
        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding)
            make.top.equalTo(loginPageDescription.snp.bottom).offset(Constant.gap)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding)
            make.top.equalTo(emailTextField.snp.bottom).offset(Constant.gap)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        passwordCheckTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constant.gap)
            make.height.equalTo(mode == .login ? 0 : Constant.textFieldHeight)
        }
        
        loginButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding)
            make.height.equalTo(Constant.buttonHeight)
            make.top.equalTo(passwordCheckTextField.snp.bottom).offset(Constant.bigGap)
        }
        
        signInButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding)
            make.height.equalTo(Constant.buttonHeight)
            make.top.equalTo(loginButton.snp.bottom).offset(Constant.gap)
        }
        
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
