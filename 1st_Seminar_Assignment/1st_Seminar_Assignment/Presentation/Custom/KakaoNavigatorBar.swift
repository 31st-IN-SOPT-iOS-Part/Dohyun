//
//  KakaoNavigatorBar.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/14/22.
//

import UIKit

final class KakaoNavigationBar: UIView {
    
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
        var viewWidth: [CGFloat]  = []
        
        switch viewType {
        case .home(let barViews, _):
            let navibarViews = barViews.enumerated().map { (index, view) -> UIView in
                switch view {
                case .label(let content):
                    viewWidth.append(content.intrinsicContentSize.width)
                    content.snp.makeConstraints { make in
                        make.width.equalTo(content.intrinsicContentSize.width)
                    }
                    content.setContentCompressionResistancePriority(.required, for: .horizontal)
                    content.setContentHuggingPriority(.required, for: .horizontal)
                    return content
                    
                case .smallGap(let width):
                    viewWidth.append(width)
                    return UIView().then {
                        $0.backgroundColor = .blue
                        $0.snp.makeConstraints { make in
                            make.width.equalTo(width)
                        }
                        
                        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//                        $0.setContentHuggingPriority(.required, for: .horizontal)
                        
                        smallGapIdx.append(index)
                    }
                case .flexibleView:
                    flexIndex.append(index)
                    return UIView().then {
                        $0.backgroundColor = .red
                        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
//                        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
                    }
                case .setting, .xbutton:
                    return UIButton().then {
                        $0.setBackgroundImage(view.image!, for: .normal)
                        $0.snp.makeConstraints { make in
                            make.width.equalTo(Constant.navigationBarHeight - Constant.gap * 2)
                        }
                        $0.setContentHuggingPriority(.required, for: .horizontal)
//                        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
                        viewWidth.append(Constant.navigationBarHeight - Constant.gap * 2)
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
                        if flexIndex.contains(index) {
                            
                            make.width.equalToSuperview().offset(-(viewWidth.reduce(0, +) / CGFloat(viewWidth.count + 1))).dividedBy(flexIndex.count)
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
