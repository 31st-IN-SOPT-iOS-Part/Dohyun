//
//  KakaoNavigationView.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/13/22.
//

import UIKit

enum KakaoNavigationViewFactory: Buildable {
    
    typealias ViewType = UIView
    
    case home(barViews: [KakaoNavigationItemView], completions: [(UIAction) -> Void] = [])
    
    enum KakaoNavigationItemView {
        
        case setting
        case title(content: String)
        case xbutton(color: UIColor)
        case flexibleView
        case smallGap(width: CGFloat)
        
        var image: UIImage? {
            switch self {
            case .setting:
                return UIImage(systemName: "gearshape.fill")!.withTintColor(.black, renderingMode: .alwaysOriginal)
            case .xbutton(let color):
                return UIImage(systemName: "xmark")!.withTintColor(color, renderingMode: .alwaysOriginal)
            case .flexibleView, .smallGap(_), .title:
                return nil
            }
        }
    }
    
    func build(_ config: ((UIView) -> Void)? = nil) -> UIView {
        switch self {
        case .home(let barbuttons, let completions):
            var navView = makeNavigationView(barViews: barbuttons, completions: completions)
            if let config = config {
                navView = navView.then(config)
            }
            return navView
        }
    }
    
    private func makeNavigationView(barViews: [KakaoNavigationItemView], completions: [(UIAction) -> Void] = [] ) -> UIView {
        switch self {
        case .home:
            return KakaoNavigationBar(frame: CGRect(), viewType: self, completions: completions)
        }
    }
    
}



