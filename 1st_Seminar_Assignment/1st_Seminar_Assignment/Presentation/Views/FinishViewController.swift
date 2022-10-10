//
//  FinishViewController.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/3/22.
//

import UIKit

final class FinishViewController: UIViewController {
    
    // MARK: - UI
    private let welcomeMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.text = "복숭아님\n환영합니다"
        label.numberOfLines = 2
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmButton: UIButton = UIButton.makeKakaoButton(title: "확인", origin: CGPoint(x: CGFloat(Constant.padding), y: UIScreen.main.bounds.height * 1/2)) { [weak self] _ in
        guard let self = self else {return}
        self.gotoLoginViewController()
    }
    
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
        super.init(nibName: nil, bundle: nil)
        self.welcomeMessageLabel.text = "\(id)님\n환영합니다"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private Function `

extension FinishViewController {
    
    // MARK: - UI Configuration
    private func configureViews() {
        view.backgroundColor = .white
        [welcomeMessageLabel, confirmButton].forEach {
            self.view.addSubview($0)
        }
        confirmButton.backgroundColor = .yellow
        confirmButton.setTitleColor(.label, for: .normal)
        welcomeMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeMessageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height / 4).isActive = true
        
    }
    
    // MARK: - Transition
    private func gotoLoginViewController() {
        self.popNavigation()
        self.dismiss(animated: true)
    }
    
}


