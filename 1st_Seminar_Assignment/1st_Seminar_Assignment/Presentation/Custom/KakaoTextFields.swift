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
    
    /// TextField build로 textfield 객체 생성
    /// - Parameter origin: 위치
    /// - Returns: UITextfield
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
    
    private func makeTextField(placeholder: String, origin: CGPoint) -> UITextField {
        let size = CGSize(width: UIScreen.main.bounds.width - Constant.padding * 2, height: Constant.textFieldHeight)
        let textfield = UITextField(frame: CGRect(origin: origin, size: size))
        textfield.underlineStyle()
        textfield.placeholder = placeholder
        return textfield
    }
    
}

