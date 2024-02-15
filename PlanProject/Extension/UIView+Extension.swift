//
//  UIView+Extension.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit

extension UIView: ReusableIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}
