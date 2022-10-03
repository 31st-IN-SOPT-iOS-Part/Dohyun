//
//  LoginMode.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/3/22.
//

import UIKit

enum AuthFlowViewControllerBuilder {

    case login
    case signIn
    case finish

    func buildViewController() -> UIViewController {
        switch self {
        case .login:
            return makeLoginViewController(mode: .login)
        case .signIn:
            return makeLoginViewController(mode: .signIn)
        case .finish:
            return makeFinishViewController()
        }
    }

    private func makeLoginViewController(mode: LoginMode) -> LoginViewController {
        return LoginViewController(mode: mode)
    }
    
    private func makeFinishViewController() -> FinishViewController {
        return FinishViewController()
    }
    
    
    static func start() -> UIViewController {
        login.buildViewController()
    }
    

}
