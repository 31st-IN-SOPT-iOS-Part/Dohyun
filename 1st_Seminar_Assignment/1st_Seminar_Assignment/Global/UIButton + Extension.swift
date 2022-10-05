//
//  UIButton + Extension.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/5/22.
//

import UIKit

extension UIButton {

    /// - Parameters:
    ///   - title: 버튼 타이틀
    ///   - origin: 버튼 위치를 origin으로 잡는다
    ///   - completion: 버튼이 눌린 뒤에 어떤 것을 할지?
    /// - Returns: UIButton
    static func makeKakaoButton(title: String, origin: CGPoint, completion: ((UIAction) -> Void)? = nil) -> UIButton {
        let size = CGSize(width: UIScreen.main.bounds.width - Constant.padding * 2, height: Constant.buttonHeight)
        let button = UIButton(frame: CGRect(origin: origin, size: size), primaryAction: UIAction(title: title, handler: completion ?? {_ in return}))
        button.layer.cornerRadius = Constant.buttonRadius
        button.backgroundColor = .lightGray
        return button
    }
}
