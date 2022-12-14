//
//  KakaoNavigatorBar.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/14/22.
//

import UIKit

class KakaoNavigationBar: UIView {
    
    typealias buttonAction = (UIAction) -> Void
    
    var viewType: KakaoNavigationViewFactory
    var actions: [buttonAction]
    
    init(frame: CGRect, viewType: KakaoNavigationViewFactory, completions: [buttonAction] = []) {
        self.viewType = viewType
        self.actions = completions
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(){
        
        var flexIndex = 1
        var smallGapIdx: [Int] = []
        
        switch viewType {
        case .home(let navTitle, let barViews, _):
            
            let label = UILabel().then {
                $0.text = navTitle
                $0.font = .preferredFont(forTextStyle: .title1)
                $0.setContentHuggingPriority(.required, for: .horizontal)
            }
            
            var navibarViews = barViews.enumerated().map { (index, view) -> UIView in
               
                switch view {
                case .smallGap(let width):
                    return UIView().then {
                        $0.backgroundColor = .clear
                        $0.snp.makeConstraints { make in
                            make.width.equalTo(width)
                        }
                        $0.setContentHuggingPriority(.required, for: .horizontal)
                        smallGapIdx.append(index+1)
                    }
                case .flexibleView:
                    flexIndex += index
                    return UIView().then {
                        $0.backgroundColor = .clear
                        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
                    }
                case .setting, .xbutton:
                    return UIButton().then {
                        $0.setBackgroundImage(view.image!, for: .normal)
                        $0.setContentHuggingPriority(.required, for: .horizontal)
                        guard !actions.isEmpty else {return}
                        let action = actions.removeFirst()
                        $0.addAction(UIAction(handler: action), for: .touchUpInside)
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
                            if !smallGapIdx.contains(index) {
                                make.width.equalTo(Constant.navigationBarHeight - Constant.gap * 2)
                            }
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
