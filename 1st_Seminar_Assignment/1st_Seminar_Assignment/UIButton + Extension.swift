//
//  UIButton + Extension.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/5/22.
//

import UIKit

extension UIButton {
    static func makeButton(title: String, origin: CGPoint, completion: ((UIAction) -> Void)? = nil) -> UIButton {
        let size = CGSize(width: UIScreen.main.bounds.width - 40, height: 60)
        let button = UIButton(frame: CGRect(origin: origin, size: size), primaryAction: UIAction(title: title, handler: completion ?? {_ in return}))
        button.backgroundColor = .lightGray
        return button
    }
}
