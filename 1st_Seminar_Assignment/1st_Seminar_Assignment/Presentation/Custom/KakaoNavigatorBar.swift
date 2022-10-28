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
        
        var flexIndex: [Int] = []
        var smallGapIdx: [Int] = []
        
        switch viewType {
        case .home(let barViews, _):
        
            var navibarViews = barViews.enumerated().map { (index, view) -> UIView in
               
                switch view {
                case .label(let content):
                    return content
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
                    flexIndex.append(index + 1)
                    print(flexIndex)
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
                        // 
                        if flexIndex.contains(index) {
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
