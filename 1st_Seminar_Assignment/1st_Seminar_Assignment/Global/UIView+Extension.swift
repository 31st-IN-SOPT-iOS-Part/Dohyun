//
//  UIView+Extension.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/14/22.
//

import UIKit

extension UIView {
    static func makeDivider(backgroundColor: UIColor = .white) -> UIView {
        return UIView().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = backgroundColor
            $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
    }
}
