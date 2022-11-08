//
//  Constant.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/5/22.
//

import UIKit

extension CGFloat {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        let ratioH: CGFloat = UIScreen.main.bounds.height / 667
        return ratio <= ratioH ? self * ratio : self * ratioH
    }
}

extension Int {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        let ratioH: CGFloat = UIScreen.main.bounds.height / 667
        return ratio <= ratioH ? CGFloat(self) * ratio : CGFloat(self) * ratioH
    }
}

class Constant {
    
    // 조만간 네임스페이스를 나눠야할듯
    
    static let padding: CGFloat = 20.adjusted
    static let buttonHeight: CGFloat = 60.adjusted
    static let buttonRadius: CGFloat = 5.adjusted
    static let textFieldHeight: CGFloat = 60.adjusted
    static let gap: CGFloat = 10.adjusted
    static let bigGap: CGFloat = 30.adjusted
    static let navigationBarHeight: CGFloat = 44.adjusted
    static let profileImageHeight: CGFloat = 60.adjusted
    
    enum ProfileConstant {
        static var imageSize = 97.adjusted
        static var buttonImagePadding = 9.adjusted
    }
    
}
