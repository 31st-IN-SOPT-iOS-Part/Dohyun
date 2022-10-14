//
//  KakaoNavigatorBar.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/14/22.
//

import UIKit

class KakaoNavigationBar: UIView {
    
    var viewType: KakaoNavigationViewFactory
    
    init(frame: CGRect, viewType: KakaoNavigationViewFactory) {
        self.viewType = viewType
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(){
        
        var flexIndex = 1
        
        switch viewType {
        case .home(let navTitle, let barViews):
            
            let label = UILabel().then {
                $0.text = navTitle
                $0.font = .preferredFont(forTextStyle: .title1)
                $0.setContentHuggingPriority(.required, for: .horizontal)
            }
            
            var navibarViews = barViews.enumerated().map { (index, view) -> UIView in
                if view != .flexibleView {
                    return UIButton().then {
                        $0.setBackgroundImage(view.image!, for: .normal)
                        $0.setContentHuggingPriority(.required, for: .horizontal)
                    }
                } else {
                    flexIndex += index
                    return UIView().then {
                        $0.backgroundColor = .clear
                        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
                    }
                }
            }
            navibarViews.insert(label, at: 0)
            
            let navigationStackView = UIStackView(arrangedSubviews:navibarViews)
                .then {
                    $0.alignment = .center
                    $0.axis = .horizontal
                    $0.distribution = .fill
                }
            
            navigationStackView
                .subviews.enumerated().forEach { (index, view) in
                    view.snp.makeConstraints { make in
                        make.top.bottom.equalToSuperview().inset(Constant.gap)
                        if index != flexIndex && index != 0 {
                            make.width.equalTo(Constant.navigationBarHeight - Constant.gap * 2)
                        }
                }
            }
            
            
            self.addSubview(navigationStackView)
            navigationStackView.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(Constant.padding)
                make.top.bottom.equalToSuperview()
            }

        }
    }
    
    
}
