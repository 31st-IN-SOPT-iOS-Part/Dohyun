//
//  KakaoTextFields.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/3/22.
//

import UIKit
import SnapKit
import Then

protocol Buildable {
    associatedtype ViewType
    func build(_ config: ((ViewType) -> Void)?) -> ViewType
}

enum KakaoTextFieldFactory: Buildable {

    typealias ViewType = UITextField

    case email(placeholder: String)
    case password(placeholder: String)
    case checkPassword(placeholder: String)

    func build(_ config: ((ViewType) -> Void)? = nil) -> ViewType {
        switch self {
        case .email(let placeholder), .password(let placeholder), .checkPassword(let placeholder):
            var textfield =  makeTextField(placeholer: placeholder)
            if let config = config {
                textfield = textfield.then(config)
            }
            return textfield
        }
    }
    
    private func makeTextField(placeholer: String) -> ViewType {
        return UITextField().then {
            $0.placeholder = placeholer
            $0.textColor = .lightGray
        }
    }
    
}

