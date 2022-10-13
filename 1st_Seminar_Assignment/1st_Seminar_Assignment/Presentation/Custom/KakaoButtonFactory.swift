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
    
    func build(_ config: ((UIButton) -> Void)?=nil) -> UIButton {
        var button = makeKakaoButton()
        if let config = config {
            button = button.then(config)
        }
        return button
    }
    
    private func makeKakaoButton() -> UIButton {
        switch self {
        case .confirmButton(let title, let completion),  .defaultButton(let title, completion: let completion):
            return UIButton.makeKakaoButton(title: title, completion: completion)
        case .noBorderButton(let title, let completion):
            let button = UIButton.makeKakaoButton(title: title, completion: completion)
            button.setTitleColor(.lightGray, for: .normal)
            button.backgroundColor = .clear
            return button
        }
    }
    
    
}
