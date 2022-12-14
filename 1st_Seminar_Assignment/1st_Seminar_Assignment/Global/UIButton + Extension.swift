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
    static func makeKakaoButton(title: String, completion: ((UIAction) -> Void)? = nil) -> UIButton {
        let button = UIButton(frame: CGRect(), primaryAction: UIAction(title: title, handler: completion ?? {_ in return}))
        button.layer.cornerRadius = Constant.buttonRadius
        return button
    }
    
    static func makeKakaoButton(image: UIImage, completion: ((UIAction) -> Void)? = nil) -> UIButton {
        let button = UIButton(frame: CGRect(), primaryAction: UIAction(handler: completion ?? {_ in return}))
        button.setBackgroundImage(image, for: .normal)
        button.layer.cornerRadius = Constant.buttonRadius
        return button
    }
}
