//
//  AuthLabelFactory.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/13/22.
//


import UIKit

enum KakaoLabelFactory: Buildable {
    
    typealias ViewType = UILabel
    
    case title(text: String)
    case description(text: String)
    case name(text: String)
    
    func build(_ config: ((UILabel) -> Void)?=nil) -> UILabel {
        var label = makeAuthLabel()
        if let config = config {
            label = label.then(config)
        }
        return label
    }
    
    func makeAuthLabel() -> UILabel {
        
        let label = UILabel()
        label.textAlignment = .center
        
        switch self {
        case .title(let text):
            label.text = text
            label.font = .preferredFont(forTextStyle: .largeTitle)
        case .description(let text):
            label.text = text
            label.numberOfLines  = 2
            label.textColor = .lightGray
        case .name(let text):
            label.text = text
            label.textColor = .white
            label.font = .preferredFont(forTextStyle: .headline)
        }
        return label
    }
}
