//
//  KakaoNavigationView.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/13/22.
//

import UIKit

enum KakaoNavigationViewFactory: Buildable {
    
    typealias ViewType = UIView
    
    case home(navTitle: String? = nil, barViews: [KakaoNavigationItemView], completions: [(UIAction) -> Void] = [])
    
    enum KakaoNavigationItemView {
        
        case setting
        case xbutton(color: UIColor)
        case flexibleView
        case smallGap(width: CGFloat)
        
        var image: UIImage? {
            switch self {
            case .setting:
                return UIImage(systemName: "gearshape.fill")!.withTintColor(.black, renderingMode: .alwaysOriginal)
            case .xbutton(let color):
                return UIImage(systemName: "xmark")!.withTintColor(color, renderingMode: .alwaysOriginal)
            case .flexibleView, .smallGap(_):
                return nil
            }
        }
    }
    
    func build(_ config: ((UIView) -> Void)? = nil) -> UIView {
        switch self {
        case .home(let navTitle, let barbuttons, let completions):
            var navView = makeNavigationView(title: navTitle,
                                             barViews: barbuttons, completions: completions)
            if let config = config {
                navView = navView.then(config)
            }
            return navView
        }
    }
    
    private func makeNavigationView(title: String?, barViews: [KakaoNavigationItemView], completions: [(UIAction) -> Void] = [] ) -> UIView {
        switch self {
        case .home:
            return KakaoNavigationBar(frame: CGRect(), viewType: self, completions: completions)
        }
    }
    
}



