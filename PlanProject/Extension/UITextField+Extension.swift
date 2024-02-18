//
//  UITextField+Extension.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit


extension UITextField {
    
    func setPlaceholder(string: String, color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}

