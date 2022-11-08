//
//  UITextField + Extension.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/5/22.
//

import UIKit

extension UITextField {
    
    func underlineStyle(textColor: UIColor = .lightGray, borderColor: UIColor = .lightGray, padding: CGFloat = Constant.padding, height: CGFloat = Constant.textFieldHeight) {
        self.borderStyle = .none
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: height - 10, width: UIScreen.main.bounds.width - (2*padding), height: 1)
        bottomLine.backgroundColor = borderColor.cgColor
        self.layer.addSublayer(bottomLine)
        self.textColor = textColor
    }
    
}
