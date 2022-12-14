//
//  KakaoTextFields.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/3/22.
//

import UIKit
import SnapKit
import Then

enum KakaoTextFieldFactory: Buildable {

    typealias ViewType = UITextField
    
    enum TextfieldBorderStyle {
        case underline
        case round
    }

    case email(placeholder: String, borderStyle: TextfieldBorderStyle)
    case password(placeholder: String, borderStyle: TextfieldBorderStyle)
    case checkPassword(placeholder: String, borderStyle: TextfieldBorderStyle)

    func build(_ config: ((ViewType) -> Void)? = nil) -> ViewType {
        switch self {
        case .email(let placeholder, let borderStyle), .password(let placeholder, let borderStyle), .checkPassword(let placeholder, let borderStyle):
            var textfield =  makeTextField(placeholer: placeholder, borderstyle: borderStyle)
            if let config = config {
                textfield = textfield.then(config)
            }
            return textfield
        }
    }
    
    private func makeTextField(placeholer: String, borderstyle: TextfieldBorderStyle) -> ViewType {
        return UITextField().then {
            $0.placeholder = placeholer
            $0.textColor = .lightGray
            if borderstyle == .underline {
                $0.underlineStyle()
            } else if borderstyle == .round {
                $0.borderStyle = .roundedRect
            }
        }
    }
    
}

