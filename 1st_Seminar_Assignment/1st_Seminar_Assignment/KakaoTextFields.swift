//
//  KakaoTextFields.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/3/22.
//

import UIKit

enum KakaoTextFields {
    
    case email(placeholder: String)
    case password(placeholder: String)
    case checkPassword(placeholder: String)
    
    func build(origin: CGPoint) -> UITextField {
        switch self {
        case .email(let placeholder):
            return makeTextField(placeholder: placeholder, origin: origin)
        case .password(let placeholder):
            return makeTextField(placeholder: placeholder, origin: origin)
        case .checkPassword(let placeholder):
            return makeTextField(placeholder: placeholder, origin: origin)
        }
    }
    
    // 커스텀
    private func makeTextField(placeholder: String, origin: CGPoint) -> UITextField {
        let size = CGSize(width: UIScreen.main.bounds.width - 40, height: 60)
        let textfield = UITextField(frame: CGRect(origin: origin, size: size))
        textfield.placeholder = placeholder
        textfield.borderStyle = .none
        textfield.textColor = .lightGray
        return textfield
    }
    
}
