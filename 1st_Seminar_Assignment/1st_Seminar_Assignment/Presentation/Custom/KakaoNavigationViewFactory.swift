//
//  KakaoNavigationView.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/13/22.
//

import UIKit

enum KakaoNavigationViewFactory: Buildable {
    
    typealias ViewType = UIView
    
    enum KakaoNavigationItemView {
        
        case setting
        case xbutton
        case flexibleView
        
        var image: UIImage? {
            switch self {
            case .setting:
                return UIImage(systemName: "gearshape.fill")!.withTintColor(.black)
            case .xbutton:
                return UIImage(systemName: "xmark")!
            case .flexibleView:
                return nil
            }
        }
    }
    
    case home(navTitle: String? = nil, barViews: [KakaoNavigationItemView])
    
    func build(_ config: ((UIView) -> Void)? = nil) -> UIView {
        switch self {
        case .home(let navTitle, let barbuttons):
            var navView = makeNavigationView(title: navTitle, barViews: barbuttons)
            if let config = config {
                navView = navView.then(config)
            }
            return navView
        }
    }
    
    private func makeNavigationView(title: String?, barViews: [KakaoNavigationItemView]) -> UIView {
        switch self {
        case .home:
            return KakaoNavigationBar(frame: CGRect(), viewType: self)
        }
    }
    
}



