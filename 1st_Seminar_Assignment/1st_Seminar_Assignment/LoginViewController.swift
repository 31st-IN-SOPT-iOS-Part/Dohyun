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
    // UI만드는 방법 1
    private lazy var loginPageTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 30, y: 100, width:0, height: 0))
        label.text = "카카오톡을 시작합니다"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.sizeToFit()
        return label
    }()
    
    private lazy var loginPageDescription: UILabel = {
        let label = UILabel(frame: CGRect(x: loginPageTitleLabel.frame.origin.x, y: loginPageTitleLabel.frame.origin.y + loginPageTitleLabel.frame.height + 30, width: 0, height: 0))
        label.text = "사용하던 카카오계정이 있다면\n이메일 또는 전화번호로 로그인해주세요"
        label.textAlignment = .center
        label.numberOfLines  = 2
        label.textColor = .lightGray
        label.sizeToFit()
        return label
    }()
    
    private lazy var emailTextField = KakaoTextFields.email(placeholder: "이메일").build(origin: loginButton.frame.origin)

    private lazy var passwordTextField = KakaoTextFields.password(placeholder: "비밀번호").build(origin: loginButton.frame.origin)

    private lazy var passwordCheckTextField = KakaoTextFields.checkPassword(placeholder: "비밀번호 확인").build(origin: loginButton.frame.origin)
    
    private lazy var loginButton: UIButton = makeButton(title: "카카오계정 로그인",
                                                        origin: CGPoint(x: 20, y: loginPageDescription.frame.height + loginPageDescription.frame.origin.y + 20)) {_ in
        
    }
    
    private lazy var signInButton: UIButton = makeButton(title: "새로운 카카오계정 만들기", origin: CGPoint(x: 20, y: loginButton.frame.height + loginButton.frame.origin.y + 20)) { [weak self]_ in
        self?.gotoController()
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
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    deinit {
        print(#function)
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
        let component: [Any] = [findIdOrPasswordButton, loginPageTitleLabel, loginPageDescription, loginButton, signInButton]
        component.forEach { self.view.addSubview($0 as? UIView ?? UIView())}
        setUpConstraint()
    }
    
    private func setUpConstraint() {
        
        findIdOrPasswordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        findIdOrPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    /// 솝트 세미나 과제1 버튼 함수 (UI만드는 방법 2)
    /// - Parameters:
    ///   - title: 버튼 타이틀
    ///   - origin: 버튼 위치를 origin으로 잡는다
    ///   - completion: 버튼이 눌린 뒤에 어떤 것을 할지?
    /// - Returns: UIButton
    private func makeButton(title: String, origin: CGPoint, completion: ((UIAction) -> Void)? = nil) -> UIButton {
        let size = CGSize(width: UIScreen.main.bounds.width - 40, height: 60)
        let button = UIButton(frame: CGRect(origin: origin, size: size), primaryAction: UIAction(title: title, handler: completion ?? {_ in return}))
        button.backgroundColor = .lightGray
        return button
    }
    
    private func gotoController() {
        guard let signUpViewController = AuthFlowViewControllerBuilder.signIn.buildViewController() as? LoginViewController else {return}
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
}
