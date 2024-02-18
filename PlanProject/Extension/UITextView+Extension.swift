//
//  UITextView+Extension.swift
//  PlanProject
//
//  Created by 김진수 on 2/18/24.
//

import UIKit

extension UITextView {
    func resolveHashTags() -> String {
        var hashTag = self.text.components(separatedBy: .whitespaces)
        
        var result = hashTag.map{ "#" + $0 }.joined(separator: " ")
        
        return result
    }
}
