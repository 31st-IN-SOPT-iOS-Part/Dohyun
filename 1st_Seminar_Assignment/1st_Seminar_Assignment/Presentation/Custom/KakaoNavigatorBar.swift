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
        
        var flexibleViewIndex: [Int] = []
        var smallGapIdx: [Int] = []
        var viewWidth: [CGFloat]  = []
        
        switch viewType {
        case .home(let barViews, _):
            let navibarViews = barViews.enumerated().map { (index, view) -> UIView in
                switch view {
                case .title(let content):
                    return setLabelContent(content: content, viewWidth: &viewWidth)
                case .smallGap(let width):
                    return setSmallGap(width: width, index: index, viewWidth: &viewWidth, smallGapIdx: &smallGapIdx)
                case .flexibleView:
                    flexibleViewIndex.append(index)
                    return UIView().then {
                        $0.backgroundColor = .red
                        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
                        $0.translatesAutoresizingMaskIntoConstraints = false
                    }
                    
                case .setting, .xbutton:
                    return UIButton().then {
                        $0.setBackgroundImage(view.image!, for: .normal)
                        $0.translatesAutoresizingMaskIntoConstraints = false
                        $0.widthAnchor.constraint(equalToConstant: Constant.navigationBarHeight - Constant.gap * 2).isActive = true
                        $0.setContentHuggingPriority(.required, for: .horizontal)
                        viewWidth.append(Constant.navigationBarHeight - Constant.gap * 2)
                        
                        guard !actions.isEmpty else {return}
                        let action = actions.removeFirst()
                        $0.addAction(UIAction(handler: action), for: .touchUpInside)
                    }
                }
            }
            
            let navigationStackView = addNavigationStackView(in: navibarViews)
            navigationStackView.subviews.enumerated().forEach { (index, view) in
                    setSubviewOfStackView(index: index, view: view, flexibleviewIndex: flexibleViewIndex, viewWidth: viewWidth)
                }
        }
        
    }
    
    private func setSubviewOfStackView(index: Int, view: UIView, flexibleviewIndex: [Int], viewWidth: [CGFloat]) {
        view.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constant.gap)
            if flexibleviewIndex.contains(index) {
                make.width.equalToSuperview().offset(-(viewWidth.reduce(0, +) / CGFloat(viewWidth.count + 1))).dividedBy(flexibleviewIndex.count)
            }
        }
    }
    
    private func setSmallGap(width: CGFloat, index: Int, viewWidth: inout [CGFloat], smallGapIdx: inout [Int]) -> UIView {
        viewWidth.append(width)
        return UIView().then {
            $0.backgroundColor = .blue
            
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: width).isActive = true
            
            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            smallGapIdx.append(index)
        }
    }
    
    private func setLabelContent(content: String, viewWidth: inout [CGFloat]) -> UILabel {
        let label = UILabel().then {
            $0.text = content
            $0.font = .preferredFont(forTextStyle: .title1)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        setLabelContraint(label: label)
        viewWidth.append(label.intrinsicContentSize.width)
        return label
    }
    
    private func setLabelContraint(label: UILabel) {
        label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width).isActive = true
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func addNavigationStackView(in views: [UIView]) -> UIStackView {
        let navigationStackView = UIStackView(arrangedSubviews:views)
            .then {
                $0.alignment = .center
                $0.axis = .horizontal
                $0.distribution = .fill
            }
        setupStackViewLayout(with: navigationStackView)
        return navigationStackView
    }
    
    private func setupStackViewLayout(with navigationStackView: UIStackView){
        self.addSubview(navigationStackView)
        navigationStackView.translatesAutoresizingMaskIntoConstraints = false
        [navigationStackView.topAnchor.constraint(equalTo: self.topAnchor),
         navigationStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         navigationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.padding),
         navigationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constant.padding),
        ].forEach { $0.isActive = true
        }

    }
    
    
}
