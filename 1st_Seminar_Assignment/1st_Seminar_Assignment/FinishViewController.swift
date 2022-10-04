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
        label.text = "복숭아님\n환영합니다"
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmButton: UIButton = UIButton.makeButton(title: "확인", origin: CGPoint(x: 20, y: 200)) { [weak self] _ in
        // Delay Deallocation을 활용한 dismiss 후 popViewcontroller
        guard let self = self else {return}
        self.gotoLoginViewController()
    }
    
    // MARK: - Properties
    private var popNavigation: (()-> Void)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Init
    init(id: String, transition: @escaping ()->Void) {
        self.popNavigation = transition
        super.init(nibName: nil, bundle: nil)
        self.welcomeMessageLabel.text = id
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private Function `

extension FinishViewController {
    
    // MARK: - UI Configuration
    private func configureViews() {
        [welcomeMessageLabel, confirmButton].forEach {
            self.view.addSubview($0)
        }
        
    }
    
    // MARK: - Transition
    private func gotoLoginViewController() {
        self.dismiss(animated: true, completion: self.popNavigation)
    }
    
}


