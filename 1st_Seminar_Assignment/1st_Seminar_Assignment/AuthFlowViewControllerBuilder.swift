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
    case finish(id: String, transition: ()->Void)

    func buildViewController() -> UIViewController {
        switch self {
        case .login:
            return makeLoginViewController(mode: .login)
        case .signIn:
            return makeLoginViewController(mode: .signIn)
        case .finish(let id, let transition):
            return makeFinishViewController(id: id, transition: transition)
        }
    }

    private func makeLoginViewController(mode: LoginMode) -> LoginViewController {
        return LoginViewController(mode: mode)
    }
    
    private func makeFinishViewController(id: String, transition: @escaping (()->Void)) -> FinishViewController {
        return FinishViewController(id: id, transition: transition)
    }
    
    
    static func start() -> UIViewController {
        login.buildViewController()
    }
    

}
