//
//  UITextField + Extension.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/5/22.
//

import UIKit

extension UITextField {
    
    func underlineStyle(textColor: UIColor = .lightGray, borderColor: UIColor = .lightGray) {
        self.borderStyle = .none
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 10, width: self.bounds.width, height: 1)
        bottomLine.backgroundColor = borderColor.cgColor
        self.layer.addSublayer(bottomLine)
        self.textColor = textColor
    }
    
}
