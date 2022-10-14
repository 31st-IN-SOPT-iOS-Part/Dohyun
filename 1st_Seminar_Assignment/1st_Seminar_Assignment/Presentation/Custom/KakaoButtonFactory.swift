//
//  KakaoButtonFactory.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/13/22.
//

import UIKit

enum KakaoButtonFactory: Buildable {
    
    typealias ViewType = UIButton
    
    case confirmButton(title: String, completion: ((UIAction) -> Void)?=nil)
    case defaultButton(title: String, completion: ((UIAction) -> Void)?=nil)
    case noBorderButton(title: String, completion: ((UIAction) -> Void)?=nil)
    case profileButton(image: UIImage, completion: ((UIAction) -> Void)?=nil)
    case iconButton(icon: KakaoButtonIcon , title: String?, completion: ((UIAction) -> Void)?=nil)
    
    
    enum KakaoButtonIcon: String, CaseIterable {
        
        case edit = "나와의 채팅"
        case story = "프로필 편집"
        case talk = "카카오스토리"
        
        var image: UIImage? {
            switch self {
            case .edit:
                return UIImage(named: "profile_editImg")
            case .story:
                return UIImage(named: "profileStoryImg")
            case .talk:
                return UIImage(named: "profileTalkImg")
            }
        }
    }
    
    func build(_ config: ((UIButton) -> Void)?=nil) -> UIButton {
        var button = makeKakaoButton()
        button.adjustsImageWhenHighlighted = false
        if let config = config {
            button = button.then(config)
        }
        return button
    }
    
    private func makeKakaoButton() -> UIButton {
        switch self {
        case .defaultButton(let title, completion: let completion):
            return UIButton.makeKakaoButton(title: title, completion: completion).then {
                $0.backgroundColor = .lightGray
            }
        case .confirmButton(let title, let completion):
            return UIButton.makeKakaoButton(title: title, completion: completion).then {
                $0.backgroundColor = .yellow
                $0.setTitleColor(.label, for: .normal)
            }
        case .noBorderButton(let title, let completion):
            let button = UIButton.makeKakaoButton(title: title, completion: completion)
            button.setTitleColor(.lightGray, for: .normal)
            button.backgroundColor = .clear
            return button
        case .profileButton(let image, let completion):
            let button = UIButton.makeKakaoButton(image: image, completion: completion)
            button.layer.cornerRadius = 10
            return button
        case .iconButton(let icon, let title, let completion):
            var config = UIButton.Configuration.plain()
            config.subtitle = title
            config.imagePlacement = .top
            config.image = icon.image
            let button = UIButton(configuration: config, primaryAction: UIAction(handler: completion ?? {_ in }))
            return button
        }
        
    }
    
    
}
